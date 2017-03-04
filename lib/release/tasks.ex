defmodule Release.Tasks do
  def migrate do
    {:ok, _} = Application.ensure_all_started(:shovik_com)

    path = Application.app_dir(:shovik_com, "priv/repo/migrations")
    Ecto.Migrator.run(ShovikCom.Repo, path, :up, all: true)
  end
end
