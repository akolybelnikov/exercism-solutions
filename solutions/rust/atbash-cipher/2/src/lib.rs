static ALPHABET: &str = "abcdefghijklmnopqrstuvwxyz";

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    transform(plain.chars())
        .enumerate()
        .flat_map(|(i, c)| {
            if i != 0 && i % 5 == 0 {
                Some(' ')
            } else {
                None
            }
            .into_iter()
            .chain(std::iter::once(c))
        })
        .collect()
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    transform(cipher.chars()).collect()
}

fn symmetric(c: char) -> char {
    let i: usize = ALPHABET
        .chars()
        .position(|ch| ch == c.to_ascii_lowercase())
        .unwrap();
    ALPHABET.chars().nth(ALPHABET.len() - 1 - i).unwrap()
}

fn transform<T>(items: T) -> impl Iterator<Item = char>
where
    T: Iterator<Item = char>,
{
    items.filter(|ch| ch.is_alphanumeric()).map(|c| match c {
        c if c.is_alphabetic() => symmetric(c),
        _ => c,
    })
}
