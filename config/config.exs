# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :elph_shell,
  ecto_repos: [ElphShell.Repo]

# Configures the endpoint
config :elph_shell, ElphShellWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: ElphShellWeb.ErrorView, accepts: ~w(json)],
  pubsub_server: ElphShell.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure your database
config :elph_shell, ElphShell.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: 10

#########

# Configure elph
config :elph,
  repo: ElphShell.Repo,
  types: ElphShell.Types,
  callbacks: ElphShell.Callbacks,
  upload_dir: "/app/uploads/",
  url_upload_dir: "/uploads",
  page_size: 14

###########

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: ElphShell.Coherence.User,
  repo: ElphShell.Repo,
  module: ElphShell,
  web_module: ElphShellWeb,
  router: ElphShellWeb.Router,
  password_hashing_alg: Comeonin.Bcrypt,
  messages_backend: ElphShellWeb.Coherence.Messages,
  registration_permitted_attributes: [
    "email",
    "name",
    "password",
    "current_password",
    "password_confirmation"
  ],
  password_reset_permitted_attributes: [
    "reset_password_token",
    "password",
    "password_confirmation"
  ],
  session_permitted_attributes: ["email", "password"],
  email_from_name: "ElphShell",
  email_from_email: "elphshell@example.com",
  opts: [:recoverable, :authenticatable],
  auth_module: ElphShellWeb.Coherence.TokenAuth,
  credential_store: Coherence.CredentialStore.Server,
  require_current_password: false,
  allow_silent_password_recovery_for_unknown_user: true

config :coherence, ElphShellWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: {:system, "SMTP_HOST"},
  # username: {:system, "SMTP_USERNAME"},
  # password: {:system, "SMTP_PASSWORD"},
  # ssl: true,
  # auth: :always,
  port: {:system, "SMTP_PORT"},
  retries: 3

# %% End Coherence Configuration %%

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
