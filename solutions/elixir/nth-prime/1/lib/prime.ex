defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise(ArgumentError, "There is no zeroth prime")
  def nth(count) do
    upper_limit =
      if count < 6 do
        15
      else
        floor(count * (:math.log(count) + :math.log(:math.log(count)))) + 10
      end

    sieve = :array.new(upper_limit + 1, [{:default, true}])
    sieve = :array.set(0, false, sieve)
    sieve = :array.set(1, false, sieve)

    sieve =
      Enum.reduce(2..floor(:math.sqrt(upper_limit)), sieve, fn i, s ->
        if :array.get(i, s) do
          Enum.reduce((i * i)..upper_limit//i, s, fn j, acc ->
            :array.set(j, false, acc)
          end)
        else
          s
        end
      end)

    :array.to_list(sieve)
    |> Enum.with_index()
    |> Enum.filter(fn {is_prime, _} -> is_prime end)
    |> Enum.map(fn {_, idx} -> idx end)
    |> Enum.at(count - 1)
  end
end
