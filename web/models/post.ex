defmodule ShovikCom.Post do
  use ShovikCom.Web, :model

  import Ecto.Changeset

  schema "posts" do
    belongs_to :author, ShovikCom.User

    field :title, :string
    field :url, :string
    field :body, :string
    field :publish_at, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :url, :body, :publish_at, :author_id])
    |> validate_required([:title, :body, :author_id])
  end
end
