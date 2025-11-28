/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    let mut encoded = String::new();
    let alphabet = "abcdefghijklmnopqrstuvwxyz";
    let mut index: u8 = 0;
    for c in plain.to_lowercase().chars().into_iter() {
        if c.is_alphanumeric() {
            if index != 0 && index % 5 == 0 {
                encoded.push(' ');
            }
            if c.is_alphabetic() {
                let i: usize = alphabet.chars().position(|ch| ch == c).unwrap();
                let ch: char = reverse_string(alphabet).as_bytes()[i] as char;
                encoded.push(ch);
            } else {
                encoded.push(c);
            }
            index += 1;
        }
    }

    encoded
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    let mut decoded = String::new();
    let ralphabet = "zyxwvutsrqponmlkjihgfedcba";

    for c in cipher.to_lowercase().chars().into_iter() {
        if c.is_alphanumeric() {
            if c.is_alphabetic() {
                let i: usize = ralphabet.chars().position(|ch| ch == c).unwrap();
                let ch: char = reverse_string(ralphabet).as_bytes()[i] as char;
                decoded.push(ch);
            } else {
                decoded.push(c);
            }
        }
    }

    decoded
}

fn reverse_string(s: &str) -> String {
    s.chars().rev().collect()
}
