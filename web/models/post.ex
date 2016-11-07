defmodule ShovikCom.Post do
  use ShovikCom.Web, :model

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
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :url, :body, :author_id, :publish_at])
    |> validate_required([:title, :body])
  end
end
