defmodule ShovikCom.Factory do
  use ExMachina.Ecto, repo: ShovikCom.Repo

  alias ShovikCom.User
  alias ShovikCom.Post

  def user_factory do
    %User{
      email: sequence(:email, &"user#{&1}@test.com"),
      first_name: sequence(:first_name, &"First#{&1}"),
      last_name: sequence(:last_name, &"Last#{&1}"),
      password: "12341234",
      password_confirmation: "12341234",
      password_digest: Comeonin.Bcrypt.hashpwsalt("12341234"),
    }
  end

  def post_factory do
    %Post{
      author: build(:user),
      title: sequence(:title, &"Awesome blog about your mom #{&1}"),
      url: sequence(:url, &"awesome-blog-about-your-mom-#{&1}"),
      body: "Yadayadayada... about your mom bwa-ha-ha-ha-ha!"
    }
  end
end
