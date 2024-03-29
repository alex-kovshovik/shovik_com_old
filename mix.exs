defmodule ShovikCom.Mixfile do
  use Mix.Project

  def project do
    [app: :shovik_com,
     version: "0.0.24",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {ShovikCom, []}]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:comeonin, "~> 3.0"},
     {:credo, "~> 0.5.2", runtime: false},
     {:mix_test_watch, "~> 0.2.6"},
     {:ex_machina, "~> 1.0"},
     {:earmark, "~> 1.0"},
     {:timex, "~> 3.1.7"},
     {:timex_ecto, "~> 3.1.1"},
     {:cachex, "~> 2.0"},
     {:scrivener_ecto, "~> 1.0"},
     {:scrivener_html, "~> 1.1"},

     # File attachments
     {:arc, "~> 0.6.0"},
     {:arc_ecto, "~> 0.5.0"},
     {:ex_aws, "~> 1.0.0"},
     {:hackney, "~> 1.6"},
     {:poison, "~> 2.0"},
     {:sweet_xml, "~> 0.6.3"},

     # Deployment
     {:distillery, "~> 1.1"},
     {:mix_docker, "0.3.2"}
   ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "ecto.seed"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "ecto.seed": ["run priv/repo/seeds.exs"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
