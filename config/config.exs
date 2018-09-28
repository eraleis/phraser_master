# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phraser_master,
  ecto_repos: [PhraserMaster.Repo]

# Configures the endpoint
config :phraser_master, PhraserMasterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BnDWnAzsfNdH+V6fMMbRe/2mtzBpGHh33owwklKoPerkZ3S7QQj2z9/ELQJ7Ev++",
  render_errors: [view: PhraserMasterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhraserMaster.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
