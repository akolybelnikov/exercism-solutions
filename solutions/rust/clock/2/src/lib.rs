#[derive(Debug, PartialEq)]
pub struct Clock {
    pub hours: i32,
    pub minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let clock = Clock { hours, minutes };

        match clock {
            Clock { hours, minutes } if hours < 0 && minutes >= 0 => {
                let hours = find_hours(hours.abs()) + minutes / 60 % 24;
                Clock { hours, minutes }
            }
            Clock { hours, minutes } if hours >= 0 && minutes >= 0 => {
                let hours = (hours + minutes / 60 % 24) % 24;
                let minutes = minutes % 60;
                Clock { hours, minutes }
            }
            Clock { hours, minutes } if hours < 0 && minutes < 0 => {
                let hours = find_hours(hours.abs());
                let hours = if minutes.abs() != 60 {
                    hours + minutes / 60 % 24 - 1
                } else {
                    hours + minutes / 60 % 24
                };
                let minutes = if minutes.abs() != 60 {
                    60 + minutes % 60
                } else {
                    0
                };
                if hours > 0 && hours != 24 {
                    Clock { hours, minutes }
                } else {
                    let hours = find_hours(hours.abs());
                    Clock { hours, minutes }
                }
            }
            Clock { hours, minutes } if hours >= 0 && minutes < 0 => {
                let hours = if minutes.abs() != 60 {
                    hours + minutes / 60 % 24 - 1
                } else {
                    hours + minutes / 60 % 24
                };
                let minutes = if minutes.abs() != 60 {
                    60 + minutes % 60
                } else {
                    0
                };
                if hours >= 0 && hours != 24 {
                    Clock { hours, minutes }
                } else {
                    let hours = find_hours(hours.abs());
                    Clock { hours, minutes }
                }
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
