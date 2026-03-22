defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: opts()) :: {:ok, opts()} | {:error, error()}

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end

  @callback handle_frame(dot :: dot(), frame_number :: frame_number(), opts :: opts()) :: dot()
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame, _opts) do
    case frame do
      x when rem(x, 4) == 0 ->
        %DancingDots.Dot{x: dot.x, y: dot.y, radius: dot.radius, opacity: dot.opacity / 2}

      _ ->
        dot
    end
  end
end

defmodule DancingDots.Zoom do
  @behaviour DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    velocity = Keyword.fetch(opts, :velocity)

    case velocity do
      {:ok, v} when is_number(v) -> {:ok, opts}
      {:ok, v} -> option_error(v)
      _ -> option_error(nil)
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame, opts) do
    velocity = Keyword.fetch!(opts, :velocity)
    new_radius = dot.radius + velocity * (frame - 1)
    %DancingDots.Dot{x: dot.x, y: dot.y, radius: new_radius, opacity: dot.opacity}
  end

  defp option_error(value) do
    {:error,
     "The :velocity option is required, and its value must be a number. Got: #{inspect(value)}"}
  end
end
