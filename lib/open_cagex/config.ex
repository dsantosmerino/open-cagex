defmodule OpenCagex.Config do
  @moduledoc """
  Allows to modify and retrieve your OpenCagex configuration
  """

  @doc """
  Modifies your API Key value

  ## Example
      iex> OpenCagex.Config.api_key("YOUR API KEY")
      :ok
  """
  def api_key(api_key) do
    Application.put_env(:open_cagex, :api_key, api_key)
  end

  @doc """
  Returns your API Key configuration value

  ## Example
      iex> OpenCagex.Config.api_key("YOUR API KEY")
      :ok
      iex> OpenCagex.Config.api_key
      "YOUR API KEY"
  """
  def api_key do
    get_env(:api_key)
  end

  @doc """
  Returns the API Url configuration value

  ## Example
      iex> OpenCagex.Config.api_url
      "http://api.opencagedata.com/geocode/v1/"
  """
  def api_url do
    get_env(:api_url)
  end

  defp get_env(key) do
    Application.get_env(:open_cagex, key)
  end
end
