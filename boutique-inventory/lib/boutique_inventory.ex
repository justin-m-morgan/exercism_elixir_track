defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort(inventory, &(&1.price <= &2.price))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(!&1.price))
  end

  def increase_quantity(item, count) do
    update_in(item, [:quantity_by_size], fn quantities ->
      quantities
      |> Enum.map(fn {size, quantity} -> {size, quantity + count} end)
      |> Enum.into(%{})
    end)
  end

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Enum.reduce(0, &(elem(&1, 1) + &2))
  end
end
