Application.ensure_all_started :timex # Wow! This took forever to troubleshoot!

defmodule ShovikCom.Repo.Migrations.MovePostPreviewIntoField do
  use Ecto.Migration

  import Ecto
  import Ecto.Query
  import Ecto.Changeset

  alias ShovikCom.Repo
  alias ShovikCom.Post

  def up do
    posts = from p in Post, select: p

    posts
    |> Repo.all
    |> Enum.each(&update_post/1)
  end

  def down do
    # No down migration is necessary
  end

  defp update_post(post) do
    preview = post_preview(post)

    post
    |> Post.changeset(%{preview: preview})
    |> Repo.update
  end

  def post_preview(post) do
    post.body
    |> String.split("\n\r")
    |> Enum.filter(fn(s) -> String.length(s) > 0 end)
    |> Enum.take(1)
    |> Enum.join("\n")
  end
end
