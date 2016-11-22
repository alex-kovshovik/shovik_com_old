defmodule ShovikCom.LayoutView do
  use ShovikCom.Web, :view

  def current_user_name(conn) do
    user = conn.assigns[:current_user]
    is_nil(user) && "Not Authenticated" || "#{user.first_name} #{user.last_name}"
  end

  def current_user(conn) do
    conn.assigns[:current_user]
  end
end
