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
  live_view: [signing_salt: "p3z6yq9v"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :score_goblin, ScoreGoblin.Mailer, 
  adapter: Swoosh.Adapters.SMTP,
  relay: "todo",
  username: "todo",
  password: "todo",
  ssl: false,
  tls: :always,
  auth: :always,
  port: 587,


  trace_fun: fn s, a -> Logger.notice(:io_lib.format(s, a)) end,
  # dkim: [
  #   s: "default", d: "domain.com",
  #   private_key: {:pem_plain, File.read!("priv/keys/domain.private")}
  # ],
  retries: 2,
  no_mx_lookups: false

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
