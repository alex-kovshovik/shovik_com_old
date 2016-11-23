defmodule ShovikCom.LayoutViewTest do
  use ShovikCom.ConnCase, async: true

  import ShovikCom.Factory
  import Plug.Conn

  alias ShovikCom.LayoutView

  setup do
    user = insert(:user)
    conn =
      build_conn()
      |> assign(:current_user, user)

    {:ok, conn: conn, user: user}
  end

  test "current user returns the user in the session", %{conn: conn} do
    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session", %{conn: conn, user: user} do
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end

  test "calculates years of experience" do
    assert LayoutView.years_of_experience > 10 # LOL
  end
end
