defmodule ShovikCom.PageControllerTest do
  use ShovikCom.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Alex Kovshovik"
  end
end
