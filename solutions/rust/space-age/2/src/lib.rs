#[macro_use]
extern crate planet_derive;

#[derive(Debug)]
pub struct Duration(f64);

impl From<u64> for Duration {
    fn from(s: u64) -> Self {
        Duration(s as f64/31557600f64)
    }
}

pub trait Planet {
    fn years_during(d: &Duration) -> f64;
}

#[derive(Planet)]
pub struct Mercury;

#[derive(Planet)]
pub struct Venus;

#[derive(Planet)]
pub struct Earth;

#[derive(Planet)]
pub struct Mars;

#[derive(Planet)]
pub struct Jupiter;

#[derive(Planet)]
pub struct Saturn;

#[derive(Planet)]
pub struct Uranus;

#[derive(Planet)]
pub struct Neptune;
