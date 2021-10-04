defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    budget = options[:maximum_price] || 100

    for top <- tops,
        bottom <- bottoms,
        not_clashing_colors(top, bottom) and within_budget(top, bottom, budget) do
      {top, bottom}
    end
  end

  defp not_clashing_colors(top, bottom) do
    top.base_color != bottom.base_color
  end

  defp within_budget(top, bottom, budget) do
    top.price + bottom.price < budget
  end
end
