defmodule PhraserMaster.Date do
  def unix_week! do
    DateTime.utc_now()
    |> unix_week!()
  end

  def unix_week!(datetime) do
    datetime
    |> DateTime.to_unix()
    |> Kernel./(604_800)
    |> Kernel.trunc()
  end

  def monday do
    date =
      Date.utc_today()
      |> Date.to_erl()

    from_monday = :calendar.day_of_the_week(date) - 1

    date
    |> :calendar.date_to_gregorian_days()
    |> Kernel.-(from_monday)
    |> :calendar.gregorian_days_to_date()
    |> Date.from_erl!()
  end
end
