#[derive(Debug, PartialEq)]
pub struct Clock {
    pub hours: i32,
    pub minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let clock = Clock { hours, minutes };

        match clock {
            Clock { hours, minutes } if minutes >= 0 => {
                let hours = if hours < 0 {
                    find_hours(hours.abs()) + minutes / 60 % 24
                } else {
                    (hours + minutes / 60 % 24) % 24
                };
                let minutes = minutes % 60;
                Clock { hours, minutes }
            }
            Clock { hours, minutes } if hours < 0 && minutes < 0 => {
                let hours = find_hours(hours.abs());
                let (hours, minutes) = find_hours_and_minutes(hours, minutes);
                find_clock(hours, minutes)
            }
            Clock { hours, minutes } if hours >= 0 && minutes < 0 => {
                let (hours, minutes) = find_hours_and_minutes(hours, minutes);
                find_clock(hours, minutes)
            }
            _ => Clock { hours, minutes },
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        let minutes = &self.minutes + minutes;
        Clock::new(self.hours, minutes)
    }

    pub fn to_string(&self) -> String {
        format!("{:0>2}:{:0>2}", &self.hours, &self.minutes)
    }
}

pub fn find_hours(hours: i32) -> i32 {
    if hours > 24 {
        24 - hours % 24
    } else if hours == 24 {
        0
    } else {
        24 - hours
    }
}

pub fn find_hours_and_minutes(hours: i32, minutes: i32) -> (i32, i32) {
    let (hours, minutes) = if minutes.abs() != 60 {
        (hours + minutes / 60 % 24 - 1, 60 + minutes % 60)
    } else {
        (hours + minutes / 60 % 24, 0)
    };
    (hours, minutes)
}

pub fn find_clock(hours: i32, minutes: i32) -> Clock {
    if hours >= 0 && hours != 24 {
        Clock { hours, minutes }
    } else {
        let hours = find_hours(hours.abs());
        Clock { hours, minutes }
    }
}
