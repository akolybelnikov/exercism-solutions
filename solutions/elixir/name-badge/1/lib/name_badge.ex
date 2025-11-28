defmodule NameBadge do
  def print(id, name, department) do
    id_part = if id, do: "[#{id}] - ", else: ""
    dept = department || "OWNER"

    "#{id_part}#{name} - #{String.upcase(dept)}"
  end
end
