defmodule PmLogin.MixProject do
  use Mix.Project

  def project do
    [
      app: :pm_login,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PmLogin.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.9"},
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.6.2"},
      {:postgrex, ">= 0.15.9"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.3.1", only: :dev},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:contex, git: "https://github.com/mindok/contex"},
      {:plug_cowboy, "~> 2.5.0"},
      {:comeonin, "~> 4.0"},
      {:bcrypt_elixir, "~> 1.0"},
      {:phoenix_live_view, "~> 0.15.7"},
      {:floki, ">= 0.31.0", only: :test}

  #DEPS.UPDATE 18/06/2021
  #     cowboy 2.8.0 => 2.9.0
  # cowlib 2.9.1 => 2.11.0
  # db_connection 2.3.1 => 2.4.0
  # ecto 3.5.8 => 3.6.2
  # ecto_sql 3.5.4 => 3.6.2
  # floki 0.30.1 => 0.31.0 (minor)
  # mime 1.5.0 => 1.6.0
  # phoenix 1.5.8 => 1.5.9
  # phoenix_live_reload 1.3.0 => 1.3.1
  # phoenix_live_view 0.15.4 => 0.15.7
  # plug_cowboy 2.4.1 => 2.5.0
  # plug_crypto 1.2.1 => 1.2.2
  # postgrex 0.15.8 => 0.15.9
  # ranch 1.7.1 => 1.8.0
  # telemetry 0.4.2 => 0.4.3
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
