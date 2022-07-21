import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elph_shell, ElphShellWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :elph_shell, ElphShell.Repo, pool: Ecto.Adapters.SQL.Sandbox

case System.get_env("TEST_DATABASE_URL") do
  nil -> :noop
  database_url -> config :elph_shell, ElphShell.Repo, url: database_url
end

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
