defmodule ShovikCom.BlogView do
  use ShovikCom.Web, :view

  def markdown(body) do
    body
    |> Earmark.to_html(%Earmark.Options{breaks: true})
    |> raw
  end
end
