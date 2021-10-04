defmodule LibraryFees do
  # UTC +0
  @local_timezone "Etc/UTC"

  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    case before_noon?(checkout_datetime) do
      true -> add_days(checkout_datetime, 28)
      false -> add_days(checkout_datetime, 29)
    end
  end

  defp add_days(%NaiveDateTime{} = datetime, days) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> maybe_return_zero()
  end

  defp maybe_return_zero(diff) when diff < 0, do: 0
  defp maybe_return_zero(diff), do: diff

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week(:monday)
    |> Kernel.==(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    return = datetime_from_string(return)

    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(return)
    |> Kernel.*(rate)
    |> maybe_discount(return)
    |> Kernel.floor()
  end

  defp maybe_discount(fees, return) do
    if monday?(return), do: fees * 0.5, else: fees
  end
end
