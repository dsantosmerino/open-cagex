defmodule OpenCagex do
  alias OpenCagex.{Api, Config, Parser}

  @moduledoc """
  Provides simple and easy to use reverse (lat/long to text) and forward 
  (text to lat/long) geocode via OpenCage Gecoder API

  See: https://geocoder.opencagedata.com/api
  """

  @doc """
  Returns a formatted address for the given coordinates
  """
  def reverse(lat, lng) do
    case Api.get_by_coordinates(lat, lng) do
      {:ok, response} -> Parser.formatted_address(response)
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Returns a geocode for the given place name
  """
  def geocode(place_name) do
    case Api.get_by_place_name(place_name) do
      {:ok, response} -> Parser.geocode(response)
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Returns details from opencagedata request for the given place name
  """
  def detail(place_name) do
    case Api.get_by_place_name(place_name) do
      {:ok, response} -> Parser.detail(response)
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Sets an API key
  """
  def set_api_key(api_key) do
    Config.api_key(api_key)
  end
end
