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
                let hours = hours.abs();
                let hours = if hours > 24 {
                    24 - hours % 24
                } else if hours == 24 {
                    0
                } else {
                    24 - hours
                };
                let hours = hours + minutes / 60 % 24;
                Clock { hours, minutes }
            }
            Clock { hours, minutes } if hours >= 0 && minutes >= 0 => {
                let hours = (hours + minutes / 60 % 24) % 24;
                let minutes = minutes % 60;
                Clock { hours, minutes }
            }
            Clock { hours, minutes } if hours < 0 && minutes < 0 => {
                let hours = hours.abs();
                let hours = if hours > 24 {
                    24 - hours % 24
                } else if hours == 24 {
                    0
                } else {
                    24 - hours
                };
                let hours = if minutes.abs() != 60 {
                    (hours + minutes / 60 % 24) - 1
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
                    let hours = hours.abs();
                    if hours > 24 {
                        let hours = 24 - hours % 24;
                        Clock { hours, minutes }
                    } else if hours == 24 {
                        Clock { hours: 0, minutes }
                    } else {
                        let hours = 24 - hours;
                        Clock { hours, minutes }
                    }
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
                    let hours = hours.abs();
                    if hours > 24 {
                        let hours = 24 - hours % 24;
                        Clock { hours, minutes }
                    } else if hours == 24 {
                        Clock { hours: 0, minutes }
                    } else {
                        let hours = 24 - hours;
                        Clock { hours, minutes }
                    }
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
