const MINE: u8 = b'*';
const EMPTY: u8 = b' ';

pub fn annotate(minefield: &[&str]) -> Vec<String> {
    match (minefield.len(), minefield.first().map(|s| s.len())) {
        (0, _) => vec![],
        (_, Some(0)) => vec![String::new()],
        _ => {
            let row_len = minefield.len();
            let col_len = minefield[0].len();
            let mut result = vec![vec![0; col_len]; row_len];

            for i in 0..row_len {
                for j in 0..col_len {
                    result[i][j] = count_mines(minefield, i, j);
                }
            }

            result
                .iter()
                .map(|row| {
                    row.iter()
                        .map(|&cell| {
                            if cell == MINE {
                                '*'
                            } else if cell == EMPTY {
                                ' '
                            } else {
                                (cell + b'0') as char
                            }
                        })
                        .collect::<String>()
                })
                .collect::<Vec<String>>()
        }
    }
}

fn count_mines(minefield: &[&str], i: usize, j: usize) -> u8 {
    if minefield[i].as_bytes()[j] == MINE {
        return MINE;
    }

    let dx: [i32; 3] = [-1, 0, 1];
    let dy: [i32; 3] = [-1, 0, 1];
    let mut count = 0;

    for &x in dx.iter() {
        for &y in dy.iter() {
            if x == 0 && y == 0 {
                continue;
            }

            let nx = (i as i32) - (-x);
            let ny = (j as i32) - (-y);

            if (nx as usize) < minefield.len() && (ny as usize) < minefield[0].len() {
                if minefield[nx as usize].as_bytes()[ny as usize] == MINE {
                    count += 1;
                }
            }
        }
    }

    if count > 0 {
        return count;
    }

    EMPTY
}
