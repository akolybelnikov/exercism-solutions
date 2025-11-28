use std::fmt::{Display, Formatter, Result};

#[derive(Debug, PartialEq)]
pub struct Clock {
    pub minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        // Step 1: convert all arguments to minutes
        let minutes = hours * 60 + minutes;
        // Step 2: parse out the number of hours regardless of the vector
        let hours = minutes / 60;
        // Step 3: normalize hours
        let hours = if hours < 0 {
            normalize_hours(hours.abs())
        } else {
            hours
        };
        // Step 4: wrap hours
        let hours = if minutes < 0 && minutes.abs() != 60 {
            hours - 1
        } else {
            hours
        };
        // Step 5: normalize wrapped hours
        let hours = if hours > 0 && hours != 24 {
            hours % 24
        } else {
            normalize_hours(hours.abs()) % 24
        };
        // Step 6: normalize minutes and add hours converted to minutes
        let minutes = if minutes < 0 {
            60 + minutes % 60 + hours * 60
        } else {
            minutes % 60 + hours * 60
        };
        Clock { minutes }
    }
    pub fn add_minutes(&self, minutes: i32) -> Self {
        // Step 1: get new number of minutes
        let minutes = self.minutes + minutes;
        // Step 2: hours have to be nulified because we only store minutes
        Clock::new(0, minutes)
    }
}

impl Display for Clock {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        write!(f, "{:0>2}:{:0>2}", self.minutes / 60, self.minutes % 60)
    }
}

pub fn normalize_hours(hours: i32) -> i32 {
    match hours {
        h if h > 24 => 24 - h % 24,
        h if h == 24 => 0,
        h => 24 - h,
    }
}
