defmodule ShovikCom.LayoutView do
  use ShovikCom.Web, :view

  alias ShovikCom.Repo
  alias ShovikCom.User

  def current_user_name(conn) do
    user = current_user(conn)
    is_nil(user) && "Not Authenticated" || "#{user.first_name} #{user.last_name}"
  end

  def current_user(conn) do
    user = Plug.Conn.get_session(conn, :current_user)
    user && Repo.get(User, user.id)
  end
end
