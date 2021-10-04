defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    # Please implement the daily_rate/1 function
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    # Please implement the apply_discount/2 function
    before_discount
    |> Kernel.*(100 - discount)
    |> Kernel./(100)
    |> Float.round(6)

  end

  def monthly_rate(hourly_rate, discount) do
    # Please implement the monthly_rate/2 function
    monthly_work_hours = 176
    (hourly_rate * monthly_work_hours) * (100 - discount) / 100
    |> Float.ceil()
    |> trunc

  end

  def days_in_budget(budget, hourly_rate, discount) do
    # Please implement the days_in_budget/3 function
    discounted_daily_rate = (daily_rate(hourly_rate) |> apply_discount(discount))

    budget / discounted_daily_rate
    |> Float.floor(1)
    # |> apply_discount(discount)
  end
end
