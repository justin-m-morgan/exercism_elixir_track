defmodule NameBadge do
  def print(id, name, department) do
    department = if department, do: department, else: "Owner"
    id = if id, do: "[#{id}] - ", else: ""

    id <> "#{name} - #{department |> String.upcase()}"
  end
end
