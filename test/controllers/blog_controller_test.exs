defmodule ShovikCom.BlogControllerTest do
  use ShovikCom.ConnCase

  alias ShovikCom.TestHelper

  setup do
    {:ok, user} = TestHelper.create_user(%{email: "test@test.com",
                                           password: "test",
                                           password_confirmation: "test",
                                           first_name: "test",
                                           last_name: "test"})

    {:ok, post} = TestHelper.create_post(user, %{title: "Test post 1",
                                                 body: "Test post body1",
                                                 publish_at: DateTime.utc_now })

    conn = build_conn() |> login_user(user)
    {:ok, conn: conn, user: user, post: post}
  end

  defp login_user(conn, user) do
    post conn, session_path(conn, :create), user: %{email: user.email, password: user.password}
  end

  @tag watching: true
  test "lists last 5 posts on index", %{conn: conn} do
    conn = get conn, blog_path(conn, :index)
    assert html_response(conn, 200) =~ "Post previews here"
  end

  @tag watching: true
  test "displays one post", %{conn: conn, post: post} do
    conn = get conn, blog_path(conn, :show, post)
    assert html_response(conn, 200) =~ "Post details here"
  end
end
