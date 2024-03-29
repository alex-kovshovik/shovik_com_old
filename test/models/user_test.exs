defmodule ShovikCom.UserTest do
  use ShovikCom.ModelCase

  alias ShovikCom.User

  @valid_attrs %{email: "some content", first_name: "some content", last_name: "some content", password: "some content", password_confirmation: "some content"}
  @nopw_attrs %{email: "some content", first_name: "some content", last_name: "some content", password: nil, password_confirmation: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "password_digest values gets set to a hash" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, Ecto.Changeset.get_change(changeset, :password_digest))
  end

  test "password_digest value does not get set if password is nil" do
    changeset = User.changeset(%User{}, @nopw_attrs)
    refute Ecto.Changeset.get_change(changeset, :password_digest)
  end
end
