defmodule OpenCagex.Response do
  @moduledoc """
  Allows to handle responses from OpenCagex.Api
  """

  @errors %{
    400 => "Invalid request (bad request; a required parameter is missing; invalid coordinates)",
    402 => "Valid request but quota exceeded (payment required)",
    403 => "Invalid or missing API key",
    404 => "Invalid API endpoint",
    408 => "Timeout; you can try again",
    410 => "Request too long",
    429 => "Too many requests (too quickly, rate limiting)",
    503 => "Internal server error",
  }

  @doc """
  Handles and parses :ok responses with status 200
  """
  def handle({:ok, %{status_code: 200} = response}) do
    response
    |> parse_body
  end

  @doc """
  Handles and parses :ok responses with status different than 200
  """
  def handle({:ok, %{status_code: status_code}}) do
    {:error, Map.get(@errors, status_code)}
  end

  @doc """
  Handles and parses :error responses
  """
  def handle({:error, response}), do: {:error, response}

  defp parse_body(response) do
    Poison.decode(response.body)
  end
end
