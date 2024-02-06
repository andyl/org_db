defmodule OrgDb.MixProject do
  use Mix.Project

  def project do
    [
      app: :org_db,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {OrgDb.Application, []}
    ]
  end

  defp deps do
    [
      # ----- basics
      {:jason, "~> 1.4"},
      {:bandit, "~> 1.0"},
      {:exqlite, "~> 0.18"},
      {:file_system, "~> 1.0"},
      {:uniq, "~> 0.6"},
      # ----- testing
      {:mix_test_interactive, path: "~/src/Forks/mix_test_interactive", only: :dev, runtime: false}
    ]
  end
end
