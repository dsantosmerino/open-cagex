defmodule OpenCagex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :open_cagex,
      version: "0.1.2",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      name: "OpenCagex",
      package: package(),
      source_url: "https://github.com/dsantosmerino/open-cagex"
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [:httpoison],
      env: [
        api_key: nil,
        api_url: "http://api.opencagedata.com/geocode/v1/"
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 1.5"},
      {:poison, "~> 3.1"},
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:mock, "~> 0.3.1", only: :test}
    ]
  end

  defp description do
    "An OpenCage Geocoder API wrapper written in Elixir"
  end

  defp package do
    [
      maintainers: ["David Santos Merino"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/dsantosmerino/open-cagex"}
    ]
  end
end
