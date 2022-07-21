defmodule ElphShell.MixProject do
  use Mix.Project

  def project do
    [
      app: :elph_shell,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_paths: ["deps/elph/test"],
      preferred_cli_env: [
        test: :test,
        "test.setup": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ElphShell.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "deps/elph/lib", "deps/elph/test", "test/support"]
  defp elixirc_paths(_), do: ["lib", "deps/elph/lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.7"},
      {:myxql, "~> 0.6.0"},
      {:gettext, "~> 0.19"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:coherence, "~> 0.6", github: "appprova/coherence"},
      {:gen_smtp, "~> 0.13"},
      {:timex, "~> 3.0"},
      {:elph, "~> 0.9"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "ecto.seed"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test.setup": ["ecto.drop", "ecto.create --quiet", "ecto.migrate"]
    ]
  end
end
