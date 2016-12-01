defmodule ShovikCom.BlogView do
  use ShovikCom.Web, :view

  def markdown(body) do
    body
    |> Earmark.to_html(%Earmark.Options{breaks: true})
    |> raw
  end

  def format_posted_at(publish_at) do
    {:ok, date_string} = publish_at |> Timex.format("{YYYY}-{M}-{D}")
    date_string
  end
end
