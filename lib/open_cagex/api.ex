defmodule OpenCagex.Api do
  @moduledoc """
  Provides OpenCage Geocoder API interfaces
  """

  alias OpenCagex.{Config, Response}

  @doc """
  Calls the API using a place name as q param
  """
  def get_by_place_name(place_name) do
    request(%{q: place_name})
  end

  @doc """
  Calls the API using a pair of coordinates as q param
  """
  def get_by_coordinates(lat, lng) do
    request(%{q: "#{lat},#{lng}"})
  end

  defp request(params) do
    params
    |> build_qs_params
    |> build_url
    |> HTTPoison.get
    |> Response.handle()
  end

  defp build_url(qs_params) do
    "#{Config.api_url}/json?#{qs_params}"
  end

  defp build_qs_params(specific_params) do
    specific_params
    |> Map.merge(%{key: Config.api_key})
    |> URI.encode_query()
  end
end
