// This stub file contains items which aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

/// various log levels
#[derive(Clone, PartialEq, Debug)]
pub enum LogLevel {
    Info,
    Warning,
    Error,
}
/// primary function for emitting logs
pub fn log(level: LogLevel, message: &str) -> String {
    let mut log_message = String::from(message);
    match level {
        LogLevel::Info => log_message.insert_str(0, "[INFO]: "),
        LogLevel::Warning => log_message.insert_str(0, "[WARNING]: "),
        LogLevel::Error => log_message.insert_str(0, "[ERROR]: ")
    }
    log_message
}
pub fn info(message: &str) -> String {
    log(LogLevel::Info, message)
}
pub fn warn(message: &str) -> String {
    log(LogLevel::Warning, message)
}
pub fn error(message: &str) -> String {
    log(LogLevel::Error, message)
}
