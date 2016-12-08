defmodule ShovikCom.Admin.PostController do
  use ShovikCom.Web, :controller

  alias ShovikCom.Post
  alias ShovikCom.PostImage
  alias ShovikCom.LayoutView

  def index(conn, _params) do
    posts = Repo.all(from p in Post, preload: [:author])
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    post_cs =
      conn
      |> LayoutView.current_user
      |> build_assoc(:posts)
      |> Post.changeset

    render(conn, "new.html", post_cs: post_cs)
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
        |> redirect(to: admin_post_path(conn, :index))
      {:error, post_cs} ->
        render(conn, "new.html", post_cs: post_cs)
    end
  end

  def edit(conn, %{"id" => id}) do
    post = load_post(id)

    post_cs = Post.changeset(post)
    image_cs = image_changeset(post)

    render(conn, "edit.html", post: post, post_cs: post_cs, image_cs: image_cs)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = load_post(id)
    post_cs = Post.changeset(post, post_params)

    case Repo.update(post_cs) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: admin_post_path(conn, :edit, post))
      {:error, post_cs} ->
        render(conn, "edit.html", post: post, post_cs: post_cs, image_cs: image_changeset(post))
    end
  end

  def create_image(conn, %{"post_id" => post_id, "post_image" => image_params}) do
    post = Repo.get!(Post, post_id)

    post_image =
      post
      |> build_assoc(:post_images)
      |> PostImage.changeset(image_params)

    case Repo.insert(post_image) do
      {:ok, _image} ->
        conn
        |> put_flash(:info, "Post image is craeted")
        |> redirect(to: admin_post_path(conn, :edit, post))
      {:error, _image_cs} ->
        conn
        |> put_flash(:error, "Couldn't save the image")
        |> edit(%{"id" => post.id})
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: admin_post_path(conn, :index))
  end

  defp load_post(id) do
    Post
    |> Repo.get!(id)
    |> Repo.preload([:post_images])
  end

  defp image_changeset(post) do
    post
    |> build_assoc(:post_images)
    |> PostImage.changeset
  end
end
