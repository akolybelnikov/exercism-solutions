/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    return if code.trim().len() <= 1 {
        false
    } else {
        code.chars()
            .rev()
            .filter(|&c| !c.is_whitespace())
            .map(|c| c.to_digit(10))
            .enumerate()
            .try_fold(0, |sum, (i, c_opt)| {
                c_opt.map(|mut num| {
                    if i % 2 == 1 {
                        num *= 2;
                        if num > 9 {
                            num -= 9;
                        }
                    }
                    Ok(sum + num)
                })
                    .unwrap_or(Err(()))
            })
            .map_or(false, |sum| sum % 10 == 0)
    };
}
