defmodule Const.Mixfile do
  use Mix.Project

  def project do
    [app: :const,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     description: description()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:earmark, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.12", only: :dev}]
  end

  defp description do
    "A simple helper to define constants"
  end

  defp package do
    [
      maintainers: ["Michele Balistreri"],
      licenses: ["ISC"],
      links: %{"GitHub" => "https://github.com/bitgamma/const"}
    ]
  end
end
