# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{plots: %{}, next_id: 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn %{plots: plots} -> Map.values(plots) end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: plots, next_id: id} = state ->
      plot = %Plot{plot_id: id, registered_to: register_to}
      new_state = %{state | plots: Map.put(plots, id, plot), next_id: id + 1}
      {plot, new_state}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{plots: plots} = state ->
      %{state | plots: Map.delete(plots, plot_id)}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      case Map.get(plots, plot_id) do
        nil -> {:not_found, "plot is unregistered"}
        plot -> plot
      end
    end)
  end
end
