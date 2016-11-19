defmodule ShovikCom.BlogController do
  use ShovikCom.Web, :controller

  alias ShovikCom.Post
  alias ShovikCom.LayoutView

  def index(conn, _params) do
    posts = Repo.all(from p in Post, preload: [:author])
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end
end
