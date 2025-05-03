defmodule ElidBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :elidbot,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ElidBot.Application, []}
    ]
  end

  defp deps do
    [
      {:nostrum, "~> 0.8"},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"}
    ]
  end
end
