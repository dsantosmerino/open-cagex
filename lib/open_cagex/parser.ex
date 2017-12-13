defmodule OpenCagex.Parser do
  @moduledoc """
  Allows to parse responses from OpenCagex.Response
  """

  def geocode(results), do: get_by_key(results, "geometry")

  def formatted_address(results), do: get_by_key(results, "formatted")

  defp get_by_key(results, key) do
    value = results
    |> parse_results
    |> first_result
    |> get_key(key)

    {:ok, value}
  end

  defp parse_results(%{"results" => results}), do: results

  defp first_result(results), do: Enum.at(results, 0)

  defp get_key(nil, key), do: nil
  defp get_key(results, key), do: Map.get(results, key)
end
