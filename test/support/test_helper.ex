defmodule ShovikCom.TestHelper do
  alias ShovikCom.Repo
  alias ShovikCom.User
  alias ShovikCom.Post

  import Ecto, only: [build_assoc: 2]

  def create_user(attrs) do
    User.changeset(%User{}, attrs)
    |> Repo.insert
  end

  def create_post(user, %{title: title, body: body, publish_at: publish_at}) do
    user
    |> build_assoc(:posts)
    |> Post.changeset(%{title: title, body: body, publish_at: publish_at})
    |> Repo.insert
  end
end
