defmodule ShovikCom.LayoutViewTest do
  use ShovikCom.ConnCase, async: true

  alias ShovikCom.LayoutView
  alias ShovikCom.User

  alias ShovikCom.TestHelper

  setup do
    {:ok, user} = TestHelper.create_user(%{email: "test",
                                           password: "test",
                                           password_confirmation: "test",
                                           first_name: "test",
                                           last_name: "test"})

    {:ok, conn: build_conn(), user: user}
  end

  test "current user returns the user in the session", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{email: "test", password: "test"}
    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session", %{conn: conn} do
    user = Repo.get_by(User, %{email: "test"})
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end
