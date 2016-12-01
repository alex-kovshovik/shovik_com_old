defmodule ShovikCom.Post do
  @moduledoc """
  Post module
  """

  use ShovikCom.Web, :model

  import Ecto.Changeset

  schema "posts" do
    belongs_to :author, ShovikCom.User

    field :title, :string
    field :url, :string
    field :body, :string
    field :publish_at, Timex.Ecto.DateTime

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :url, :body, :publish_at, :author_id])
    |> validate_required([:title, :body, :author_id])
    |> strip_unsafe_body(params)
  end

  defp strip_unsafe_body(model, %{"body" => nil}), do: model
  defp strip_unsafe_body(model, %{"body" => body}) do
    {:safe, clean_body} = Phoenix.HTML.html_escape(body)

    model |> put_change(:body, clean_body)
  end
  defp strip_unsafe_body(model, _), do: model
end
