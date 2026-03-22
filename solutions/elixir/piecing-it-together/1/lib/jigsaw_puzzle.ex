defmodule JigsawPuzzle do
  @doc """
  Fill in missing jigsaw puzzle details from partial data
  """

  @type format() :: :landscape | :portrait | :square
  @type t() :: %__MODULE__{
          pieces: pos_integer() | nil,
          rows: pos_integer() | nil,
          columns: pos_integer() | nil,
          format: format() | nil,
          aspect_ratio: float() | nil,
          border: pos_integer() | nil,
          inside: pos_integer() | nil
        }

  defstruct [:pieces, :rows, :columns, :format, :aspect_ratio, :border, :inside]

  @spec data(jigsaw_puzzle :: JigsawPuzzle.t()) ::
          {:ok, JigsawPuzzle.t()} | {:error, String.t()}
  def data(%JigsawPuzzle{rows: rows, columns: cols, format: fmt})
      when fmt == :square and not is_nil(rows) and not is_nil(cols) and rows != cols do
    {:error, "Contradictory data"}
  end

  def data(%JigsawPuzzle{pieces: psc, aspect_ratio: aspr})
      when not is_nil(psc) and not is_nil(aspr) do
    rows = trunc(:math.sqrt(psc / aspr))
    cols = trunc(:math.sqrt(psc * aspr))

    fmt =
      cond do
        aspr < 1.0 -> :portrait
        aspr > 1.0 -> :landscape
        true -> :square
      end

    {:ok,
     %JigsawPuzzle{
       pieces: psc,
       rows: rows,
       columns: cols,
       format: fmt,
       aspect_ratio: aspr,
       border: 2 * (rows + cols) - 4,
       inside: psc - (2 * (rows + cols) - 4)
     }}
  end

  def data(%JigsawPuzzle{rows: rows, format: fmt})
      when fmt == :square and not is_nil(rows) do
    {:ok,
     %JigsawPuzzle{
       pieces: rows * rows,
       rows: rows,
       columns: rows,
       format: :square,
       aspect_ratio: 1.0,
       border: 4 * rows - 4,
       inside: rows * rows - (4 * rows - 4)
     }}
  end

  def data(%JigsawPuzzle{inside: inside, aspect_ratio: aspr})
      when not is_nil(inside) and not is_nil(aspr) do
    s = 1 + aspr
    rows = trunc((s + :math.sqrt(s * s - aspr * (4 - inside))) / aspr)
    cols = trunc(rows * aspr)

    fmt =
      cond do
        aspr < 1.0 -> :portrait
        aspr > 1.0 -> :landscape
        true -> :square
      end

    {:ok,
     %JigsawPuzzle{
       pieces: inside + (2 * (rows + cols) - 4),
       rows: rows,
       columns: cols,
       format: fmt,
       aspect_ratio: aspr,
       border: 2 * (rows + cols) - 4,
       inside: inside
     }}
  end

  def data(%JigsawPuzzle{rows: rows, aspect_ratio: aspr})
      when not is_nil(rows) and not is_nil(aspr) do
    cols = trunc(rows * aspr)

    fmt =
      cond do
        aspr < 1.0 -> :portrait
        aspr > 1.0 -> :landscape
        true -> :square
      end

    {:ok,
     %JigsawPuzzle{
       pieces: rows * cols,
       rows: rows,
       columns: cols,
       format: fmt,
       aspect_ratio: aspr,
       border: 2 * (rows + cols) - 4,
       inside: rows * cols - (2 * (rows + cols) - 4)
     }}
  end

  def data(%JigsawPuzzle{border: border, format: fmt, pieces: psc})
      when not is_nil(border) and not is_nil(fmt) and not is_nil(psc) do
    s = (border + 4) / 2
    root1 = trunc((s + :math.sqrt(s * s - 4 * psc)) / 2)
    root2 = trunc((s - :math.sqrt(s * s - 4 * psc)) / 2)

    {rows, cols} =
      case fmt do
        :landscape -> {min(root1, root2), max(root1, root2)}
        :portrait -> {max(root1, root2), min(root1, root2)}
        :square -> {root1, root1}
      end

    aspr = cols / rows

    {:ok,
     %JigsawPuzzle{
       pieces: psc,
       rows: rows,
       columns: cols,
       format: fmt,
       aspect_ratio: aspr,
       border: border,
       inside: psc - border
     }}
  end

  def data(_puzzle), do: {:error, "Insufficient data"}
end
