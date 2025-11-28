use std::fmt::{Display, Formatter, Result};

#[derive(Debug, PartialEq)]
pub struct Clock {
    pub minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let mut minutes = (hours * 60 + minutes) % 1_440;
        if minutes < 0 {
            minutes += 1_440;
        }
        Clock { minutes }
    }
    pub fn add_minutes(&self, minutes: i32) -> Self {
        let minutes = self.minutes + minutes;
        Clock::new(0, minutes)
    }
}

impl Display for Clock {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        let hours = (self.minutes / 60) % 24;
        let minutes = (self.minutes - (hours * 60)) % 60;
        write!(f, "{:0>2}:{:0>2}", hours, minutes)
    }
}
