defmodule ShovikCom.BlogController do
  use ShovikCom.Web, :controller

  alias ShovikCom.Post

  def index(conn, _params) do
    now = Timex.now

    posts = Repo.all(from p in Post,
                     where: p.publish_at <= ^now,
                     order_by: [desc: p.publish_at],
                     preload: [:author])
    render(conn, "index.html", posts: posts, title: "Blog")
  end

  def show(conn, %{"id" => id}) do
    id = id |> String.split("-") |> hd

    post =
      Post
      |> Repo.get!(id)
      |> Repo.preload(:author)

    render(conn, "show.html", post: post, title: post.title)
  end
end
