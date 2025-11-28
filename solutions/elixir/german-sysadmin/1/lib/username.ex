defmodule Username do
  def sanitize(username) do
    Enum.flat_map(username, &sanitize_char/1)
  end

  defp sanitize_char(x) do
    case x do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      ?_ -> ~c"_"
      c when c >= ?a and c <= ?z -> [c]
      _ -> ~c""
    end
  end
end
