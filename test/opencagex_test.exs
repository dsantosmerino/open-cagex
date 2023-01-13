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

    test "returns full details" do
      response = %{
        geometry: %{"lat" => 41.377655, "lng" => 2.1780917},
        annotations: %{
          currency: %{
            "alternate_symbols" => [],
            "decimal_mark" => ",",
            "html_entity" => "&#x20AC;",
            "iso_code" => "EUR",
            "iso_numeric" => "978",
            "name" => "Euro",
            "smallest_denomination" => 1,
            "subunit" => "Cent",
            "subunit_to_unit" => 100,
            "symbol" => "€",
            "symbol_first" => 0,
            "thousands_separator" => "."
          },
          callingcode: 34,
          timezone: %{
            "name" => "Europe/Madrid",
            "now_in_dst" => 0,
            "offset_sec" => 3600,
            "offset_string" => "+0100",
            "short_name" => "CET"
          },
          roadinfo: %{"drive_on" => "right", "speed_in" => "km/h"},
          sun: %{
            "rise" => %{
              "apparent" => 1606892400,
              "astronomical" => 1606886520,
              "civil" => 1606890540,
              "nautical" => 1606888500
            },
            "set" => %{
              "apparent" => 1606926060,
              "astronomical" => 1606932000,
              "civil" => 1606927920,
              "nautical" => 1606929960
            }
          }
        }
      }
      result = %{
        geometry: %{"lat" => 41.377655, "lng" => 2.1780917},
        currency: %{
          "alternate_symbols" => [],
          "decimal_mark" => ",",
          "html_entity" => "&#x20AC;",
          "iso_code" => "EUR",
          "iso_numeric" => "978",
          "name" => "Euro",
          "smallest_denomination" => 1,
          "subunit" => "Cent",
          "subunit_to_unit" => 100,
          "symbol" => "€",
          "symbol_first" => 0,
          "thousands_separator" => "."
        },
        callingcode: 34,
        timezone: %{
          "name" => "Europe/Madrid",
          "now_in_dst" => 0,
          "offset_sec" => 3600,
          "offset_string" => "+0100",
          "short_name" => "CET"
        },
        roadinfo: %{"drive_on" => "right", "speed_in" => "km/h"},
        sun: %{
          "rise" => %{
            "apparent" => 1606892400,
            "astronomical" => 1606886520,
            "civil" => 1606890540,
            "nautical" => 1606888500
          },
          "set" => %{
            "apparent" => 1606926060,
            "astronomical" => 1606932000,
            "civil" => 1606927920,
            "nautical" => 1606929960
          }
        }
      }

      with_request_mock response do
        expected_result = {:ok, result}
        assert expected_result == OpenCagex.detail("Passatge de la Pau, Barcelona")
      end
    end
  end
end
