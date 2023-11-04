# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

require Logger

config :score_goblin,
  ecto_repos: [ScoreGoblin.Repo]

# Configures the endpoint
config :score_goblin, ScoreGoblinWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: ScoreGoblinWeb.ErrorHTML, json: ScoreGoblinWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ScoreGoblin.PubSub,
  live_view: [signing_salt: "p3z6yq9v"],
  http: [port: 4000],
  https: [
    port: 4001,
    cipher_suite: :strong,
    certfile: "priv/cert/selfsigned.pem",
    keyfile: "priv/cert/selfsigned_key.pem"
  ]

# Configures the mailer
smtp_relay =
config :score_goblin, ScoreGoblin.Mailer, 
  adapter: Swoosh.Adapters.SMTP,
  relay: "email-smtp.us-east-2.amazonaws.com",
  port: 587,
  username: System.get_env("AWS_SES_USERNAME"),
  password: System.get_env("AWS_SES_PASSWORD"),
  tls: :always,
  tls_options: [ verify: :verify_none ]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
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

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
