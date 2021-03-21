# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pm_login,
  ecto_repos: [PmLogin.Repo]

# Configures the endpoint
config :pm_login, PmLoginWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VJObBRaEX2i3zlEP7FoZGGXXAtDkWq7vN5BvpSK4Ep4dugajTEoNHL90niulHckb",
  render_errors: [view: PmLoginWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PmLogin.PubSub,
  live_view: [signing_salt: "ZO5Cwc+7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
