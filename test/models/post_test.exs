defmodule ShovikCom.PostTest do
  use ShovikCom.ModelCase

  alias ShovikCom.Post

  @valid_attrs %{preview: "preview content", body: "some content", title: "some content", url: "some content", author_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "when the body includes script tag" do
    changeset = Post.changeset(%Post{}, %{@valid_attrs | body: "Hello <script type=''"})
    refute String.match? get_change(changeset, :body), ~r{<script>}
  end

  test "when the body includes no scary tags" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert get_change(changeset, :body) == @valid_attrs[:body]
  end
end
