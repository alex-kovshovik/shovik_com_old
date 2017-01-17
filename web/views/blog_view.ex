defmodule ShovikCom.BlogView do
  use ShovikCom.Web, :view

  import Ecto

  alias ShovikCom.Post
  alias ShovikCom.Repo
  alias ShovikCom.PostImage

  def render_post(post) do
    cached_post =
      ConCache.get(:shovik_cache, Post.cache_key(post))

    if is_nil(cached_post) do
      post_body = markdown(post.body)
      ConCache.put(:shovik_cache, Post.cache_key(post), post_body)
      post_body
    else
      cached_post
    end
  end

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
    post.preview
    |> markdown
  end

  def post_image(post) do
    post
    |> assoc(:post_images)
    |> PostImage.primary_image
    |> Repo.one
    |> post_image_url
  end

  def post_image_url(image) when is_nil(image), do: nil
  def post_image_url(image), do: ShovikCom.Picture.url({image.picture, image}, :thumb)
end
