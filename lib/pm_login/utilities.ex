defmodule PmLogin.Utilities do

  def test do
    now = NaiveDateTime.local_now
    Calendar.strftime(now, "%d/%m/%Y %Hh %M")
  end

  def simple_date_format(naive_dt) do
    Calendar.strftime(naive_dt, "%d/%m/%Y")
  end

  def simple_date_format_with_hours(naive_dt) do
    Calendar.strftime(naive_dt, "%d/%m/%Y, à %Hh %M")
  end

  def simple_date_format_with_hours_onboard(naive_dt) do
    Calendar.strftime(naive_dt, "%d/%m/%Y, %Hh %M")
  end
  def letters_date_format_with_hours(naive_dt) do

    Calendar.strftime(naive_dt,"%A %d %B %Y, %Hh %M",
       day_of_week_names: fn day_of_week ->
         {"Lundi", "Mardi", "Mercredi", "Jeudi",
         "Vendredi", "Samedi", "Dimanche"}
         |> elem(day_of_week - 1)
       end,
       month_names: fn month ->
         {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
         "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"}
         |> elem(month - 1)
       end
      )
  end

  def letters_date_format(naive_dt) do

    Calendar.strftime(naive_dt,"%A %d %B %Y",
       day_of_week_names: fn day_of_week ->
         {"Lundi", "Mardi", "Mercredi", "Jeudi",
         "Vendredi", "Samedi", "Dimanche"}
         |> elem(day_of_week - 1)
       end,
       month_names: fn month ->
         {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
         "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"}
         |> elem(month - 1)
       end
      )
  end

  def naive_to_datetime(naive) do
    {:ok, datetime} = DateTime.from_naive(naive, "Etc/UTC")
    datetime
  end

  def date_to_naive(date) do
    {:ok, naive} = {Date.to_erl(date),{0,0,0}} |> NaiveDateTime.from_erl
    naive
  end

  def date_to_datetime(date) do
    {:ok, naive} = {Date.to_erl(date),{0,0,0}} |> NaiveDateTime.from_erl
    naive_to_datetime(naive)
  end

end
