# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shovik_com,
  ecto_repos: [ShovikCom.Repo]

# Configures the endpoint
config :shovik_com, ShovikCom.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gESz7OGrkiBeJrdpvgzk3iA9ZOtEeLXZNCkdErXvg8Awnohr1E1W9TMTXMsfv5DB",
  render_errors: [view: ShovikCom.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShovikCom.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
