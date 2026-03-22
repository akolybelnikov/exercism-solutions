defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime) do
    Time.before?(NaiveDateTime.to_time(datetime), ~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    date = NaiveDateTime.to_date(checkout_datetime)
    if before_noon?(checkout_datetime) do
      Date.add(date, 28)
    else 
      Date.add(date, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    ard = NaiveDateTime.to_date(actual_return_datetime)
    if Date.after?(ard, planned_return_date) do
      Date.diff(ard, planned_return_date)
    else
      0
    end
  end

  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    prd = checkout |> datetime_from_string() |> return_date()
    return_date = datetime_from_string(return)
    late_by = days_late(prd, return_date)
    if monday?(return_date) do
      div(late_by * rate, 2)
    else
      late_by * rate
    end
  end
end
