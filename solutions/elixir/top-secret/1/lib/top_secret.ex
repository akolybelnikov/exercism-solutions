defmodule TopSecret do
  def to_ast(string) do
    {:ok, quoted} = Code.string_to_quoted(string)
    quoted
  end

  @spec decode_secret_message_part(any(), any()) :: {any(), any()}
  def decode_secret_message_part(ast, acc) do
    case ast do
      {op, _, args} = ast ->
        new_acc =
          case op do
            :def -> [decrypt_fn(args) | acc]
            :defp -> [decrypt_fn(args) | acc]
            _ -> acc
          end

        {ast, new_acc}

      _ ->
        {ast, acc}
    end
  end

  defp decrypt_fn([{function_name, _meta, args} | _rest] = list) do
    case function_name do
      :when ->
        decrypt_fn(hd(args))

      _ ->
        decrypt_fn(hd(list))
    end
  end

  defp decrypt_fn({function_name, _meta, args}) do
    function_name
    |> Atom.to_string()
    |> then(fn name ->
      if args != nil do
        String.slice(name, 0, length(args))
      else
        ""
      end
    end)
  end

  def decode_secret_message(string) do
    ast = to_ast(string)

    case ast do
      {:defmodule, _, defs} -> decrypt_message(defs)
      {:__block__, _, defs} -> decrypt_block(defs)
      _ -> :none
    end
  end

  defp decrypt_message([{:__aliases__, _, _}, [do: {:def, _, _} = def]]) do
    {_, decoded} = decode_secret_message_part(def, [])
    if Enum.empty?(decoded), do: "", else: hd(decoded)
  end

  defp decrypt_message([{:__aliases__, _, _}, [do: {:defp, _, _} = def]]) do
    {_, decoded} = decode_secret_message_part(def, [])
    if Enum.empty?(decoded), do: "", else: hd(decoded)
  end

  defp decrypt_message([{:__aliases__, _, _}, [do: {:__block__, _, defs}]]) do
    decrypt_block(defs)
  end

  defp decrypt_block(defs) do
    defs
    |> Enum.reverse()
    |> Enum.reduce("", fn def, acc ->
      case def do
        {:def, _, _} ->
          {_, decoded} = decode_secret_message_part(def, [])
          if Enum.empty?(decoded), do: acc, else: hd(decoded) <> acc

        {:defp, _, _} ->
          {_, decoded} = decode_secret_message_part(def, [])
          if Enum.empty?(decoded), do: acc, else: hd(decoded) <> acc

        {:defmodule, _, defs} ->
          decrypt_message(defs) <> acc
      end
    end)
  end
end
