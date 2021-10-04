defmodule BirdCount do
  def today([]), do: nil
  def today([today | _rest]), do: today

  def increment_day_count([]), do: [1]
  def increment_day_count([today | rest]), do: [today + 1 | rest]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _rest]), do: true
  def has_day_without_birds?([_today | rest]), do: has_day_without_birds?(rest)

  def total(list, total \\ 0)
  def total([], total), do: total
  def total([today | rest], total), do: total(rest, total + today)

  def busy_days(list, total \\ 0)
  def busy_days([], total), do: total
  def busy_days([today | rest], total) when today >= 5, do: busy_days(rest, total + 1)
  def busy_days([_today | rest], total), do: busy_days(rest, total)
end
