defmodule ShovikCom.Repo do
  use Ecto.Repo, otp_app: :shovik_com
  use Scrivener, page_size: 10
end
