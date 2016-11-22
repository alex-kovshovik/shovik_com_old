defmodule ShovikCom.PostControllerTest do
  use ShovikCom.ConnCase

  import ShovikCom.Factory

  alias ShovikCom.Post

  @valid_attrs %{body: "some content", title: "some content", url: "some content"}
  @invalid_attrs %{}

  setup do
    user = insert(:user)

    conn = build_conn() |> login_user(user)
    {:ok, conn: conn, user: user}
  end

  defp login_user(conn, user) do
    post conn, session_path(conn, :create), user: %{email: user.email, password: user.password}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, post_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing posts"
  end

  # TODO: to figure out later: how to disable authenticated users for certain tests.
  # test "redirects to home page when unauthenticated", %{conn: conn, user: user} do
  #   conn =
  #     delete(conn, session_path(conn, :delete, user))
  #     |> get(conn, post_path(conn, :index))
  #
  #   assert get_flash(conn, :error) == "You are not authorized, kindly navigate away."
  #   assert redirected_to(conn) == "/"
  #   assert conn.halted
  # end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, post_path(conn, :new)
    assert html_response(conn, 200) =~ "New post"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, post_path(conn, :create), post: @valid_attrs
    assert redirected_to(conn) == post_path(conn, :index)
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, post_path(conn, :create), post: @invalid_attrs
    assert html_response(conn, 200) =~ "New post"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, post_path(conn, :edit, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = get conn, post_path(conn, :edit, post)
    assert html_response(conn, 200) =~ "Edit post"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
    post = Repo.insert! %Post{}
    conn = put conn, post_path(conn, :update, post), post: Map.merge(@valid_attrs, %{"author_id" => user.id})
    assert redirected_to(conn) == post_path(conn, :edit, post)
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = put conn, post_path(conn, :update, post), post: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit post"
  end

  test "deletes chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = delete conn, post_path(conn, :delete, post)
    assert redirected_to(conn) == post_path(conn, :index)
    refute Repo.get(Post, post.id)
  end
end
