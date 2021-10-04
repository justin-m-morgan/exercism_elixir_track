defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    "NCC-#{Enum.random(1000..9999)}"
  end

  def random_stardate() do
    :rand.uniform()
    |> Kernel.*(1_000)
    |> Kernel.+(41_000)
  end

  def format_stardate(stardate) when is_integer(stardate) do
    raise ArgumentError
  end

  def format_stardate(stardate) do
    "#{Float.round(stardate, 1)}"
  end
end
