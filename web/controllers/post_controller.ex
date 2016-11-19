defmodule ShovikCom.PostController do
  use ShovikCom.Web, :controller

  alias ShovikCom.Post
  alias ShovikCom.LayoutView

  plug :authorize_user

  def index(conn, _params) do
    posts = Repo.all(from p in Post, preload: [:author])
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset =
      conn
      |> LayoutView.current_user
      |> build_assoc(:posts)
      |> Post.changeset

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    post =
      conn
      |> LayoutView.current_user
      |> build_assoc(:posts)
      |> Post.changeset(post_params)

    case Repo.insert(post) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :edit, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end

  defp authorize_user(conn, _opts) do
    user = LayoutView.current_user(conn)

    if user do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized, kindly navigate away.")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
