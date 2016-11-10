defmodule ShovikCom.SessionControllerTest do
  use ShovikCom.ConnCase
  alias ShovikCom.User

  setup do
    User.changeset(%User{}, %{email: "test@test.com", password: "test", password_confirmation: "test", first_name: "test", last_name: "test"})
    |> Repo.insert!

    {:ok, conn: build_conn()}
  end

  test "shows the login form", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "Login"
  end

  test "creates a new user session for a valid user", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{email: "test@test.com", password: "test"}

    assert get_flash(conn, :info) == "Sign in successful!"
    assert get_session(conn, :current_user)
    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "does not create a session with bad login", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{email: "test@test.com", password: "wrong"}

    refute get_session(conn, :current_user)
    assert get_flash(conn, :error) == "Invalid email/password combination!"
    assert redirected_to(conn) == session_path(conn, :new)
  end

  test "does not create a session if user does not exist", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{email: "wrong@test.com", password: "test"}

    assert get_flash(conn, :error) == "Invalid email/password combination!"
    assert redirected_to(conn) == session_path(conn, :new)
  end

  test "deletes the user session", %{conn: conn} do
    user = Repo.get_by(User, %{email: "test@test.com"})
    conn = delete conn, session_path(conn, :delete, user)

    refute get_session(conn, :current_user)
    assert get_flash(conn, :info) == "Signed out successfully!"
    assert redirected_to(conn) == page_path(conn, :index)
  end
end
