defmodule ShovikCom.BlogViewTest do
  use ShovikCom.ConnCase, async: true

  test "converts markdown to html" do
    {:safe, result} = ShovikCom.BlogView.markdown("**bold text**")
    assert result == "<p><strong>bold text</strong></p>\n"
  end

  test "leaves plain text as is" do
    {:safe, result} = ShovikCom.BlogView.markdown("leave this text alone")
    assert result == "<p>leave this text alone</p>\n"
  end
end
