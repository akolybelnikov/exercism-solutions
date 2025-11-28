use std::cmp::Ordering;
use std::collections::{HashMap, HashSet};

/// Given a list of poker hands, return a list of those hands which win.
static RANKS: &str = "--23456789TJQKA";

fn hand_rank(counts: &[u8]) -> u8 {
    match counts[..] {
        // High card
        [1, 1, 1, 1, 1] => 1,
        // One Pair
        [2, 1, 1, 1] => 2,
        // Two Pair
        [2, 2, 1] => 3,
        // Three of a Kind
        [3, 1, 1] => 4,
        // 5 is Straight, 6 is Flush
        // Full House
        [3, 2] => 7,
        // Four of a Kind
        [4, 1] => 8,
        // 11 is Straight Flush, 12 is Five of a Kind
        _ => 0,
    }
}

fn count(rank_counts: &HashMap<u8, u8>) -> (Vec<u8>, Vec<u8>) {
    let mut groups = Vec::new();
    for (key, val) in rank_counts.iter() {
        groups.push((val, key));
    }
    groups.sort();
    let mut counts: Vec<u8> = Vec::new();
    let mut ranks: Vec<u8> = Vec::new();
    for i in (0..groups.len()).rev() {
        counts.push(*groups[i].0);
        ranks.push(*groups[i].1);
    }
    if ranks == vec![14, 5, 4, 3, 2] {
        ranks = vec![5, 4, 3, 2, 1];
    }
    (counts, ranks)
}

fn straight(card_ranks: &[u8]) -> u8 {
    if card_ranks.len() == 5 && card_ranks[0] - card_ranks[4] == 4 {
        return 5;
    }
    0
}

fn flush(card_suits: &HashSet<String>) -> u8 {
    if card_suits.len() == 1 {
        return 6;
    }
    0
}

#[derive(Debug)]
struct Hand {
    hand_rank: u8,
    card_ranks: Vec<u8>,
}

impl Hand {
    fn new(hand: &'_ str) -> Hand {
        let cards: Vec<&str> = hand.split(' ').collect();
        let mut rank_counts = HashMap::new();
        let mut card_suits: HashSet<String> = HashSet::new();

        for card in cards {
            let s = card.chars().last().unwrap().to_string();
            card_suits.insert(s);
            // If 10 is represented as T, it will get the rank of 10, if it's 10, we pass it explicitly
            let rank = RANKS.find(card.chars().next().unwrap()).unwrap_or(10) as u8;
            if let Some(x) = rank_counts.get_mut(&rank) {
                *x += 1;
            } else {
                rank_counts.insert(rank, 1);
            }
        }
        let (counts, card_ranks) = count(&rank_counts);
        let mut hand_rank = hand_rank(&counts);
        let straight = straight(&card_ranks);
        let flush = flush(&card_suits);
        if straight + flush > hand_rank {
            hand_rank = straight + flush;
        }
        Hand {
            hand_rank,
            card_ranks,
        }
    }
}

/// Note the type signature: this function should return _the same_ reference to
/// the winning hand(s) as were passed in, not reconstructed strings which happen to be equal.
pub fn winning_hands<'a>(hands: &[&'a str]) -> Vec<&'a str> {
    let mut result: Vec<&'a str> = Vec::new();
    let mut max_val: (u8, Vec<u8>) = (0, Vec::new());
    if hands.len() == 1 {
        result.push(hands[0]);
        return result;
    }
    for h in hands {
        let poker_hand = Hand::new(h);
        let val = (poker_hand.hand_rank, poker_hand.card_ranks);
        match val.cmp(&max_val) {
            Ordering::Greater => {
                max_val = val;
                result = vec![h];
            }
            Ordering::Equal => result.push(h),
            _ => {}
        }
    }
    result
}
