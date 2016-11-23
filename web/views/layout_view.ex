defmodule ShovikCom.LayoutView do
  use ShovikCom.Web, :view

  @career_start_date ~D[2003-09-01]

  def current_user_name(conn) do
    user = conn.assigns[:current_user]
    is_nil(user) && "Not Authenticated" || "#{user.first_name} #{user.last_name}"
  end

  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def years_of_experience do
    Timex.today.year - @career_start_date.year
  end
end
