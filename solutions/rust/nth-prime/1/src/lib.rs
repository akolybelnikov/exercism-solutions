pub fn nth(n: u32) -> u32 {
    let mut primes: Vec<u32> = vec![2];
    while primes.len() <= n as usize {
        let mut curr = primes[primes.len() - 1] + 1;
        loop {
            if is_prime(curr) {
                primes.push(curr);
                break;
            } else {
                curr += 1;
            }
        }
    }
    primes[n as usize]
}

fn is_prime(num: u32) -> bool {
    let mut prime = true;
    for x in 2..=(num / 2) {
        if num % x == 0 {
            prime = false;
            break;
        }
    }
    prime
}
