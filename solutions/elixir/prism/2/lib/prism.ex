defmodule Prism do
  @doc """
  Finds the sequence of prisms that the laser will hit.
  """

  @type start :: %{angle: number(), x: number(), y: number()}
  @type prism :: %{id: integer(), angle: number(), x: number(), y: number()}

  @spec find_sequence(prisms :: [prism()], start :: start()) :: [integer()]
  def find_sequence(prisms, start) do
    {{min_x, max_x}, {min_y, max_y}} = find_min_max(prisms)
    bounds = {{min_x, max_x}, {min_y, max_y}}

    # Keep prisms as a list for ray casting
    trace_laser(prisms, start, 0, bounds, [], nil)
  end

  @spec trace_laser(
          prisms :: [prism()],
          start :: start(),
          angle :: number(),
          bounds :: {{number(), number()}, {number(), number()}},
          acc :: [integer()],
          last_hit_id :: integer() | nil
        ) :: [integer()]
  defp trace_laser(prisms, start, angle, bounds, acc, last_hit_id) do
    # Calculate ray direction
    current_angle = normalize_angle(start.angle + angle)
    rad = :math.pi() * current_angle / 180
    ray_dir_x = :math.cos(rad)
    ray_dir_y = :math.sin(rad)

    # Find the nearest prism that the ray intersects
    nearest_prism =
      prisms
      |> Enum.filter(fn p -> p.id != last_hit_id end)
      |> Enum.map(fn prism ->
        # Vector from ray origin to prism
        to_prism_x = prism.x - start.x
        to_prism_y = prism.y - start.y

        # Distance along ray to closest point to prism (dot product)
        t = to_prism_x * ray_dir_x + to_prism_y * ray_dir_y

        # Only consider prisms ahead of us
        if t > 0 do
          # Point on ray closest to prism
          closest_x = start.x + t * ray_dir_x
          closest_y = start.y + t * ray_dir_y

          # Perpendicular distance from ray to prism
          perp_dist_x = prism.x - closest_x
          perp_dist_y = prism.y - closest_y
          perp_dist = :math.sqrt(perp_dist_x * perp_dist_x + perp_dist_y * perp_dist_y)

          # Consider it a hit if ray passes within 0.05 of prism
          if perp_dist < 0.05 do
            {prism, t, perp_dist}
          else
            nil
          end
        else
          nil
        end
      end)
      |> Enum.reject(&is_nil/1)
      |> Enum.min_by(fn {_prism, t, _dist} -> t end, fn -> nil end)

    case nearest_prism do
      nil ->
        # No more prisms - check if we're out of bounds
        test_point = %{
          x: start.x + 100 * ray_dir_x,
          y: start.y + 100 * ray_dir_y
        }

        if out_of_bonds?({test_point.x, test_point.y}, bounds) do
          Enum.reverse(acc)
        else
          # Shouldn't happen in valid test cases
          Enum.reverse(acc)
        end

      {prism, _t, _dist} ->
        # Move to the prism and continue with refracted angle
        new_start = %{angle: current_angle, x: prism.x, y: prism.y}
        trace_laser(prisms, new_start, prism.angle, bounds, [prism.id | acc], prism.id)
    end
  end

  defp normalize_angle(angle) do
    normalized = Float.round(:math.fmod(angle, 360), 3)
    if normalized < 0, do: normalized + 360, else: normalized
  end

  @spec out_of_bonds?(
          {number(), number()},
          {{number(), number()}, {number(), number()}}
        ) :: boolean()
  def out_of_bonds?({x, y}, {{min_x, max_x}, {min_y, max_y}}) do
    x < min_x || x > max_x || y < min_y || y > max_y
  end

  @spec find_min_max([prism()]) :: {{number(), number()}, {number(), number()}}
  def find_min_max(prisms) do
    {{min_x, max_x}, {min_y, max_y}} =
      prisms
      |> Enum.reduce({{0, 0}, {0, 0}}, fn %{x: x, y: y}, {{min_x, max_x}, {min_y, max_y}} ->
        {{min(min_x, x), max(max_x, x)}, {min(min_y, y), max(max_y, y)}}
      end)

    {{min_x, max_x}, {min_y, max_y}}
  end
end
