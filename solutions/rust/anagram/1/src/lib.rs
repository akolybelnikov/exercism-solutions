use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let mut hs: HashSet<&'a str> = HashSet::new();
    let w_s = word.to_lowercase();
    let mut chars: Vec<char> = w_s.chars().collect();
    chars.sort();
    let w: String = chars.into_iter().collect();
    for candidate in possible_anagrams {
        let c_s = candidate.to_lowercase();
        let mut chars: Vec<char> = c_s.chars().collect();
        chars.sort();
        let s: String = chars.into_iter().collect();
        if c_s != w_s && s == w {
            hs.insert(candidate);
        }
    }

    return hs;
}
