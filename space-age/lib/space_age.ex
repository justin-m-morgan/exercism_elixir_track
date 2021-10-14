defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_year_seconds 31_557_600
  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds_to_earth_years(seconds) / convserion(planet)
  end

  def seconds_to_earth_years(seconds), do: seconds / @earth_year_seconds

  def convserion(:mercury), do: 0.2408467
  def convserion(:venus), do: 0.61519726
  def convserion(:earth), do: 1.0
  def convserion(:mars), do: 1.8808158
  def convserion(:jupiter), do: 11.862615
  def convserion(:saturn), do: 29.447498
  def convserion(:uranus), do: 84.016846
  def convserion(:neptune), do: 164.79132
end
