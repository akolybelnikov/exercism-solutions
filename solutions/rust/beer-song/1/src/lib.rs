const VERSE0: &'static str = "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n";

const VERSE1: &'static str = "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n";

const VERSE2: &'static str = "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n";

const VERSE: [&'static str; 4] = [
    " bottles of beer on the wall, ",
    " bottles of beer.\n",
    "Take one down and pass it around, ",
    " bottles of beer on the wall.\n",
];

pub fn verse(n: u32) -> String {
    match n {
        0 => VERSE0.to_owned(),
        1 => VERSE1.to_owned(),
        2 => VERSE2.to_owned(),
        _ => {
            let mut first = String::from(VERSE[0]);
            let mut second = String::from(VERSE[1]);
            let mut fourth = String::from(VERSE[3]);
            first.insert_str(0, &n.to_string());
            second.insert_str(0, &n.to_string());
            fourth.insert_str(0, &(n - 1).to_string());

            first + &second + VERSE[2] + &fourth
        }
    }
}

pub fn sing(start: u32, end: u32) -> String {
    let mut result: String = "".to_owned();
    let range = (end..=start).collect::<Vec<u32>>();
    for (idx, _) in range.iter().enumerate() {
        result = result + &verse(start - idx as u32) + "\n";
    }
    result.remove(result.len() - 1);
    result
}
