#[macro_export]
macro_rules! hashmap {
    () => ({
        let mut m = ::std::collections::HashMap::new();
        m
    });
    ($($key:expr => $value:expr),+ $(,)?) => ({
        let mut m = ::std::collections::HashMap::new();
        $(
            m.insert($key, $value);
        )+
        m
    });
}
