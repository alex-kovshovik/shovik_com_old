defmodule ShovikCom.BlogControllerTest do
  use ShovikCom.ConnCase

  import ShovikCom.Factory

  setup do
    post = insert(:post)
    user = post.author

    conn = build_conn() |> login_user(user)
    {:ok, conn: conn, user: user, post: post}
  end

  defp login_user(conn, user) do
    post conn, session_path(conn, :create), user: %{email: user.email, password: user.password}
  end

  @tag watching: true
  test "lists last 5 posts on index", %{conn: conn} do
    conn = get conn, blog_path(conn, :index)
    assert html_response(conn, 200) =~ "Blog"
  end

  @tag watching: true
  test "displays one post", %{conn: conn, post: post} do
    conn = get conn, blog_path(conn, :show, post)
    assert html_response(conn, 200) =~ "Awesome blog about your mom"
  end
end
