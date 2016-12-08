defmodule ShovikCom.BlogController do
  use ShovikCom.Web, :controller

  alias ShovikCom.Post

  def index(conn, _params) do
    posts = Repo.all(from p in Post, preload: [:author])
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    id = id |> String.split("-") |> hd

    post =
      Post
      |> Repo.get!(id)
      |> Repo.preload(:author)

    render(conn, "show.html", post: post)
  end
end
