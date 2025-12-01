defmodule PaintByNumber do
  @moduledoc """
  Paint By Number encoding and decoding functions.
  """
  @doc """
  Calculates the number of bits needed to encode the given number of colors.
  """
  @spec palette_bit_size(non_neg_integer()) :: non_neg_integer()
  def palette_bit_size(color_count), do: color_count |> :math.log2() |> ceil()
  @doc """
  Returns an empty picture as a bitstring.
  """
  @spec empty_picture() :: bitstring()
  def empty_picture, do: <<>>
  @doc """
  Returns a test picture containing the numbers 0, 1, 2, and
  3 as fragments of size 2 bits each.
  """
  @spec test_picture() :: bitstring()
  def test_picture, do: <<0::2, 1::2, 2::2, 3::2>>
  @doc """
  Prepends a pixel with the given color index to the front of the picture.
  """
  @spec prepend_pixel(bitstring(), non_neg_integer(), non_neg_integer()) :: bitstring
  def prepend_pixel(picture, color_count, pixel_color_index) do
    bits = palette_bit_size(color_count)
    <<pixel_color_index::size(bits), picture::bitstring>>
  end
  @doc """
  Gets the color index of the first pixel in the picture.
  Returns `nil` if the picture is empty.
  """
  @spec get_first_pixel(bitstring(), non_neg_integer()) :: non_neg_integer() | nil
  def get_first_pixel(picture, color_count)
  def get_first_pixel(<<>>, _color_count), do: nil

  def get_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    <<first::size(bits), _::bitstring>> = picture
    first
  end
  @doc """
  Drops the first pixel from the picture and returns the rest.
  """
  @spec drop_first_pixel(bitstring(), non_neg_integer()) :: bitstring()
  def drop_first_pixel(picture, color_count)
  def drop_first_pixel(<<>>, _color_count), do: <<>>

  def drop_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    <<_::size(bits), rest::bitstring>> = picture
    rest
  end
  @doc """
  Concatenates two pictures into one.
  """
  @spec concat_pictures(bitstring(), bitstring()) :: bitstring()
  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
