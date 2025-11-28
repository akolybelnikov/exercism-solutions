use std::collections::HashMap;
use std::sync::mpsc::{Receiver, Sender};
use std::sync::{mpsc, Arc, Mutex};
use std::thread;

type Job = Box<dyn FnOnce(&str) -> HashMap<char, usize> + Send + 'static>;

enum Command {
    NewJob(Job, String),
    Terminate,
}

struct Worker {
    thread: Option<thread::JoinHandle<()>>,
}

impl Worker {
    fn new(
        receiver: Arc<Mutex<Receiver<Command>>>,
        result_tx: Sender<HashMap<char, usize>>,
    ) -> Worker {
        let thread = thread::spawn(move || loop {
            let command = receiver.lock().unwrap().recv().unwrap();
            match command {
                Command::NewJob(job, string) => {
                    let result = job(&string);
                    result_tx.send(result).unwrap();
                }
                Command::Terminate => {
                    break;
                }
            }
        });

        Worker {
            thread: Some(thread),
        }
    }
}

struct ThreadPool {
    workers: Vec<Worker>,
    sender: Sender<Command>,
}

impl ThreadPool {
    fn new(size: usize, result_tx: Sender<HashMap<char, usize>>) -> ThreadPool {
        assert!(size > 0);
        let (sender, receiver) = mpsc::channel();
        let receiver = Arc::new(Mutex::new(receiver));
        let mut workers = Vec::with_capacity(size);

        for _ in 0..size {
            workers.push(Worker::new(Arc::clone(&receiver), result_tx.clone()));
        }

        ThreadPool { workers, sender }
    }

    fn execute<F>(&self, f: F, string: String)
    where
        F: FnOnce(&str) -> HashMap<char, usize> + Send + 'static,
    {
        let job = Box::new(f);
        self.sender.send(Command::NewJob(job, string)).unwrap();
    }
}

impl Drop for ThreadPool {
    fn drop(&mut self) {
        for _ in &self.workers {
            self.sender.send(Command::Terminate).unwrap();
        }

        for worker in &mut self.workers {
            if let Some(thread) = worker.thread.take() {
                thread.join().unwrap();
            }
        }
    }
}

pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    if input.len() == 0 {
        return HashMap::new();
    }
    let (result_tx, result_rx): (Sender<HashMap<char, usize>>, Receiver<HashMap<char, usize>>) =
        mpsc::channel();
    let result_rx = Arc::new(Mutex::new(result_rx));
    let map = Arc::new(Mutex::new(HashMap::new()));

    let merge_thread = thread::spawn({
        let result_rx = Arc::clone(&result_rx);
        let map = Arc::clone(&map);
        move || loop {
            match result_rx.lock().unwrap().recv() {
                Ok(result) => {
                    for (key, value) in result {
                        let mut map = map.lock().unwrap();
                        let counter = map.entry(key).or_insert(0);
                        *counter += value;
                    }
                }
                Err(_) => {
                    break;
                }
            }
        }
    });

    let pool = ThreadPool::new(worker_count, result_tx.clone());

    for line in input {
        let string = line.to_string();
        pool.execute(
            |input| {
                let mut map = HashMap::new();
                for c in input.chars() {
                    if c.is_alphabetic() {
                        let counter = map.entry(c.to_ascii_lowercase()).or_insert(0);
                        *counter += 1;
                    }
                }
                map
            },
            string,
        );
    }
    drop(pool);
    drop(result_tx);

    merge_thread.join().unwrap();
    Arc::try_unwrap(map).unwrap().into_inner().unwrap()
}
