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

end
