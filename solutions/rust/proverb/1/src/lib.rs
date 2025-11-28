pub fn build_proverb(list: &[&str]) -> String {
    if list.is_empty() {
        return String::new();
    }
    let end_str = "And all for the want of a ".to_owned() + list[0] + ".";
    if list.len() == 1 {
        return end_str;
    }
    let mut x = 0;
    let mut result_str = "".to_string();
    while x < list.len() - 1 {
        result_str +=
            &*("For want of a ".to_owned() + list[x] + " the " + list[x + 1] + " was lost.\n");
        x += 1;
    }
    result_str += &*end_str;
    result_str
}
