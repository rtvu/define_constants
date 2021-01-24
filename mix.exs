defmodule DefineConstants.MixProject do
  use Mix.Project

  def project() do
    [
      app: :define_constants,
      version: "0.1.0",
      elixir: "~> 1.11",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "DefineConstants",
      source_url: "https://github.com/rtvu/define_constants",
      docs: [main: "readme", extras: ["README.md"]]
    ]
  end

  def application() do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps() do
    [
      {:ex_doc, "~> 0.23", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Elixir library to provide constants functionality."
  end

  defp package() do
    [
      licenses: ["MIT License"],
      maintainers: [],
      links: %{"Github" => "https://github.com/rtvu/define_constants"}
    ]
  end
end
