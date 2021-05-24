defmodule Transformations.MixProject do
  use Mix.Project

  def project do
    [
      app: :transformations,
      version: "0.1.0",
      elixir: "~> 1.10.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      description: "Elixir library for transforming 3D homogeneous coordinates",
      deps: deps,
      package: package,
      name: "Transformations",
      source_url: "https://github.com/anandgeorge/transformations"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:matrex, "~> 0.6"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "README.md",
        "mix.exs"
      ],
      maintainers: [
        "Anand George"
      ],
      licenses: ["simplified BSD"],
      links: %{
        "GitHub" => "https://github.com/anandgeorge/transformations"
      }
    ]
  end  
end
