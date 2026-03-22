defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    {_, pid} = Task.start_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} ->
        Map.put(results, input, :ok)

      {:EXIT, ^pid, _reason} ->
        Map.put(results, input, :error)
    after
      100 ->
        Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    previous_flag = Process.flag(:trap_exit, true)

    tasks = Enum.map(inputs, &start_reliability_check(calculator, &1))

    results =
      Enum.reduce(tasks, %{}, fn task, acc ->
        await_reliability_check_result(task, acc)
      end)

    Process.flag(:trap_exit, previous_flag)

    results
  end

  def correctness_check(calculator, inputs) do
    tasks = Enum.map(inputs, &Task.async(fn -> calculator.(&1) end))
    Task.await_many(tasks, 100)
  end
end
