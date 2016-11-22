defmodule ShovikCom.BlogView do
  use ShovikCom.Web, :view

  def markdown(body) do
    body
    |> Earmark.to_html
    |> raw
  end
end
