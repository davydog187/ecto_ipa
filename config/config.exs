# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ecto_ipa,
  ecto_repos: [EctoIpa.Repo]

# Configures the endpoint
config :ecto_ipa, EctoIpa.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VZsOuH5hxCEw+SmeHKFDzxrOrMqt2vxKgwmH5y5p4nqWhRMbBwr+QnkLaaEiMADQ",
  render_errors: [view: EctoIpa.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EctoIpa.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ecto_ipa, :brewery_db, "fc2641c84d043f86dd194acbe9c65e75"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
