defmodule ShovikCom.LayoutViewTest do
  use ShovikCom.ConnCase, async: true

  import ShovikCom.Factory

  alias ShovikCom.LayoutView

  setup do
    user = insert(:user)

    {:ok, conn: build_conn(), user: user}
  end

  test "current user returns the user in the session", %{conn: conn, user: user} do
    conn = post conn, session_path(conn, :create), user: %{email: user.email, password: "12341234"}
    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session", %{conn: conn, user: user} do
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end
