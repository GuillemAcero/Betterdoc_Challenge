# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :betterdoc_challenge,
  ecto_repos: [BetterdocChallenge.Repo]

# Configures the endpoint
config :betterdoc_challenge, BetterdocChallengeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6POmfB3kGkrhScY61rZ03W/qhdNkYpEimAcAOWS5Y6tvB0UpYmnKlMd7ff4PidTW",
  render_errors: [view: BetterdocChallengeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BetterdocChallenge.PubSub,
  live_view: [signing_salt: "XWo7qXyo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      param_nesting: "account",
      request_path: "/register",
      callback_path: "/register",
      callback_methods: ["POST"]
    ]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
