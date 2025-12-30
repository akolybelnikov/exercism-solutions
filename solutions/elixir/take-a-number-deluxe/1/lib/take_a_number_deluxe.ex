defmodule TakeANumberDeluxe do
  use GenServer

  @impl GenServer
  def init(state) do
    {:ok, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, number, new_state} ->
        {:reply, {:ok, number}, new_state, new_state.auto_shutdown_timeout}

      {:error, reason} ->
        {:reply, {:error, reason}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, number, new_state} ->
        {:reply, {:ok, number}, new_state, new_state.auto_shutdown_timeout}

      {:error, reason} ->
        {:reply, {:error, reason}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call(:reset_state, _from, state) do
    {:ok, new_state} =
      TakeANumberDeluxe.State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)

    {:reply, :ok, new_state, new_state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_message, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    auto_shutdown_timeout = Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)

    with {:ok, min_num} <- Keyword.fetch(init_arg, :min_number),
         {:ok, max_num} <- Keyword.fetch(init_arg, :max_number),
         true <- is_integer(min_num) and is_integer(max_num),
         {:ok, state} <- TakeANumberDeluxe.State.new(min_num, max_num, auto_shutdown_timeout) do
      GenServer.start_link(__MODULE__, state)
    else
      _ -> {:error, :invalid_configuration}
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.call(machine, :reset_state)
    :ok
  end
end
