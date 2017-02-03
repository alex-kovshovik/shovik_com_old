use Mix.Config

config :shovik_com, ShovikCom.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "${HOST}", port: {:system, "PORT"}],
  secret_key_base: "${SECRET_KEY_BASE}",
  cache_static_manifest: "priv/static/manifest.json",
  server: true,
  root: ".",
  version: Mix.Project.config[:version]

config :shovik_com, ShovikCom.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: "${DB_HOST}",
  database: "${DB_NAME}",
  username: "${DB_USER}",
  password: "${DB_PASSWORD}",
  pool_size: 15

config :logger,
  level: (if is_nil(System.get_env("LOG_LEVEL")), do: :debug, else: System.get_env("LOG_LEVEL") |> String.to_atom)

config :tzdata, :data_dir, "/opt/app/tzdata_data"

config :comeonin, bcrypt_log_rounds: 14
