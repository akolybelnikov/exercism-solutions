const ALPHABET_START: u8 = b'a';
const ALPHABET_END: u8 = b'z';

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    into_chunks(transform(plain.chars())).collect()
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    transform(cipher.chars()).collect()
}

fn transform<T>(items: T) -> impl Iterator<Item = char>
where
    T: Iterator<Item = char>,
{
    items
        .filter(|ch| ch.is_ascii_alphanumeric())
        .map(|c| match c {
            c if c.is_ascii_alphabetic() => {
                (ALPHABET_START + ALPHABET_END - c.to_ascii_lowercase() as u8) as char
            }
            _ => c,
        })
}

fn into_chunks(items: impl Iterator<Item = char>) -> impl Iterator<Item = char> {
    items.enumerate().flat_map(|(i, c)| {
        if i != 0 && i % 5 == 0 {
            Some(' ')
        } else {
            None
        }
        .into_iter()
        .chain(std::iter::once(c))
    })
}
