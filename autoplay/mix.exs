defmodule Autoplay.MixProject do
  use Mix.Project

  def project do
    [
      app: :autoplay,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      included_applications: [:hangman],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hangman, path: "../hangman"},
      {:dictionary, path: "../dictionary"}
    ]
  end
end
