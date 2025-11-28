#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

fn convert_to_strings<T: PartialEq + std::fmt::Display>(_list: &[T]) -> String {
    let str_vec: Vec<String> = _list
        .iter()
        .map(|n| n.to_string()) // map every integer to a string
        .collect();
    str_vec.join("") // join the strings
}

pub fn sublist<T: PartialEq + std::fmt::Display>(
    _first_list: &[T],
    _second_list: &[T],
) -> Comparison {
    // Convert numbers to strings
    let pair = (
        convert_to_strings(_first_list),
        convert_to_strings(_second_list),
    );
    // Use match with guards to filter branches
    match pair {
        (a, b) if a == b => Comparison::Equal,
        (a, b) if a.contains(&b) => Comparison::Superlist,
        (a, b) if b.contains(&a) => Comparison::Sublist,
        _ => Comparison::Unequal,
    }
}
