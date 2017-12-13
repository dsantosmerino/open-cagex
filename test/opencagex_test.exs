defmodule OpenCagexTest do
  use ExUnit.Case
  doctest OpenCagex

  import Mock

  defmacro with_request_mock(result, block) do
    quote do
      with_mock HTTPoison,
        get: fn _url ->
          {
            :ok,
            %{
              body: Poison.encode!(%{results: [unquote(result)]}),
              status_code: 200,
              headers: []
            }
          }
        end do
        unquote(block)
      end
    end
  end

  describe "when given a latitude and longitude" do
    test "reverses the coordinates and returns a formated address" do
      result = "Moog, Carrer de l'Arc del Teatre, 3, 08001 Barcelona, Spain"

      with_request_mock %{formatted: result} do
        expected_result = {:ok, result}
        assert expected_result == OpenCagex.reverse(41.3780845, 2.1751182)
      end
    end
  end

  describe "when given a place name" do
    test "returns a geocode" do
      result = %{"lat" => 41.377655, "lng" => 2.1780917}

      with_request_mock %{geometry: result} do
        expected_result = {:ok, result}
        assert expected_result == OpenCagex.geocode("Passatge de la Pau, Barcelona")
      end
    end
  end
end
