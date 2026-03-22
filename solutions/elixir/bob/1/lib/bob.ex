defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.replace(input, ~r/[\n\t\r\s]/, "")
    is_empty = input == ""
    is_question = String.ends_with?(input, "?")

    is_yelling = input =~ ~r/\p{Lu}/u and not (input =~ ~r/\p{Ll}/u)

    cond do
      is_empty -> "Fine. Be that way!"
      is_yelling and is_question -> "Calm down, I know what I'm doing!"
      is_yelling -> "Whoa, chill out!"
      is_question -> "Sure."
      true -> "Whatever."
    end
  end
end
