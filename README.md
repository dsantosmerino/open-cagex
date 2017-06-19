# OpenCagex
[![Build Status](https://travis-ci.org/dsantosmerino/open_cagex.svg?branch=master)](https://travis-ci.org/dsantosmerino/open_cagex)
[![Hex Version](https://img.shields.io/hexpm/v/open_cagex.svg)](https://hex.pm/packages/open_cagex)

An OpenCage Geocoder API wrapper written in Elixir

## Installation

  1. Add `open_cagex` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:open_cagex, "~> 0.1.0"}]
  end
  ```

## Usage

```elixir
iex> OpenCagex.set_api_key("YOUR API KEY")
:ok
iex> OpenCagex.geocode("Passatge de la Pau, Barcelona")
{:ok, %{"lat" => 41.3778504, "lng" => 2.1778608}}

iex> OpenCagex.reverse(41.3780845, 2.1751182)
{:ok, "Moog, Carrer de l'Arc del Teatre, 3, 08001 Barcelona, Spain"}
```

Documentation can be found on [HexDocs](https://hexdocs.pm/open_cagex).

## Running locally

Clone the repository
```bash
git clone git@github.com:dsantosmerino/open_cagex.git
```

Install dependencies
```bash
cd open_cagex
mix deps.get
```

To run the tests
```bash
mix test
```

To run the lint
```elixir
mix credo
```
