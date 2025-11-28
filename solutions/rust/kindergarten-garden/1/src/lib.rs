pub fn plants(_diagram: &str, _student: &str) -> Vec<&'static str> {
    _diagram.split("\n").flat_map(|row| {
        let start = ((_student.chars().next().unwrap() as u8 - 'A' as u8) * 2) as usize;

        row.chars().skip(start).take(2).map(|c| {
            match c {
                'C' => "clover",
                'G' => "grass",
                'R' => "radishes",
                'V' => "violets",
                _ => panic!("Invalid plant"),
            }
        })
    }).collect()
}
