# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :avikav_net,
  ecto_repos: [AvikavNet.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :avikav_net, AvikavNetWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: AvikavNetWeb.ErrorHTML, json: AvikavNetWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: AvikavNet.PubSub,
  live_view: [signing_salt: "2cYrMu/l"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  avikav_net: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  avikav_net: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :avikav_net, :logger, [
  {:handler, :avikav_net_sentry_handler, Sentry.LoggerHandler,
   %{
     config: %{metadata: [:file, :line]}
   }}
]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
