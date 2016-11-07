defmodule ShovikCom.PageController do
  use ShovikCom.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
