defmodule ShovikCom.BlogView do
  use ShovikCom.Web, :view

  import Ecto

  alias ShovikCom.Repo
  alias ShovikCom.PostImage

  def markdown(body) do
    body
    |> Earmark.to_html(%Earmark.Options{breaks: true})
    |> raw
  end

  def format_posted_at(publish_at) do
    {:ok, date_string} = publish_at |> Timex.format("{YYYY}-{M}-{D}")
    date_string
  end

  def post_url(post) do
    "#{post.id}-#{post.url}"
  end

  def post_preview(post) do
    post.body
    |> String.split("\n\r")
    |> Enum.filter(fn(s) -> String.length(s) > 0 end)
    |> Enum.take(1)
    |> Enum.join("\n")
    |> markdown
  end

  def post_image(post) do
    post
    |> assoc(:post_images)
    |> PostImage.primary_image
    |> Repo.one
    |> post_image_url
  end

  def post_image_url(image) when is_nil(image) do
    nil
  end

  def post_image_url(image) do
    ShovikCom.Picture.url({image.picture, image}, :thumb)
  end
end
