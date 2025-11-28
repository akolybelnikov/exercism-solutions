use proc_macro::TokenStream;
use quote::quote;
use syn;

#[proc_macro_derive(Planet)]
pub fn planet_derive(input: TokenStream) -> TokenStream {
    // Construct a representation of Rust code as a syntax tree
    // that we can manipulate
    let ast = syn::parse(input).unwrap();

    // Build the trait implementation
    impl_planet(&ast)
}

fn impl_planet(ast: &syn::DeriveInput) -> TokenStream {
    let name = &ast.ident;
    let orbital_period = match name.to_string().as_str() {
        "Mercury" => quote!(0.2408467),
        "Venus"   => quote!(0.61519726),
        "Earth"   => quote!(1.0),
        "Mars"    => quote!(1.8808158),
        "Jupiter" => quote!(11.862615),
        "Saturn"  => quote!(29.447498),
        "Uranus"  => quote!(84.016846),
        "Neptune" => quote!(164.79132),
        _ => panic!("Planet not defined."),
    };
    let gen = quote! {
        impl Planet for #name {
            fn years_during(d: &Duration) -> f64 {
                d.0 / #orbital_period
            }
        }
    };
    gen.into()
}
