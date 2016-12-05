defmodule ShovikCom.PostImage do
  @moduledoc """
  PostImage module
  """

  use ShovikCom.Web, :model
  use Arc.Ecto.Schema

  import Ecto.Changeset

  schema "post_images" do
    belongs_to :post, ShovikCom.Post

    field :picture, ShovikCom.Picture.Type

    timestamps
  end

  def changeset(post_image, params \\ %{}) do
    post_image
    |> cast(params, [:post_id])
    |> cast_attachments(params, [:picture])
    |> validate_required([:post_id, :picture])
  end
end
