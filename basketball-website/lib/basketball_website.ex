defmodule BasketballWebsite do
  def extract_from_path(data, path) when is_binary(path),
    do: extract_from_path(data, String.split(path, "."))

  def extract_from_path(data, []), do: data
  def extract_from_path(data, [hd | tail]), do: extract_from_path(data[hd], tail)

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
