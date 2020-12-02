defmodule OpenCagex.Parser do
  @moduledoc """
  Allows to parse responses from OpenCagex.Response
  """

  def geocode(results), do: get_by_key(results, "geometry")

  def detail(results) do 
    with {:ok, geometry} <- get_by_key(results, "geometry"),
         {:ok, callingcode} <- get_by_key_from_annotations(results, "callingcode"),
         {:ok, currency} <- get_by_key_from_annotations(results, "currency"),
         {:ok, timezone} <- get_by_key_from_annotations(results, "timezone"),
         {:ok, roadinfo} <- get_by_key_from_annotations(results, "roadinfo"),
         {:ok, sun} <- get_by_key_from_annotations(results, "sun")
    do
      {:ok, %{
        geometry: geometry,
        callingcode: callingcode,
        currency: currency,
        timezone: timezone,
        roadinfo: roadinfo,
        sun: sun
      }}
    end
  end

  def formatted_address(results), do: get_by_key(results, "formatted")

  defp get_by_key(results, key) do
    value = results
    |> parse_results
    |> first_result
    |> get_key(key)

    {:ok, value}
  end

  defp get_by_key_from_annotations(results, key) do
    {:ok, annotations} = get_by_key(results, "annotations")
    {:ok, annotations |> get_key(key)}
  end

  defp parse_results(%{"results" => results}), do: results

  defp first_result(results), do: Enum.at(results, 0)

  defp get_key(nil, _key), do: nil
  defp get_key(results, key), do: Map.get(results, key)
end
