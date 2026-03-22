defmodule RPNCalculator.Exception do
  # Please implement DivisionByZeroError here.
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  # Please implement StackUnderflowError here.
  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(context) do
      case context do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: " <> context}
      end
    end
  end

  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([divisor, dividend]), do: div(dividend, divisor)
  def divide(_), do: raise(StackUnderflowError, "when dividing")
end
