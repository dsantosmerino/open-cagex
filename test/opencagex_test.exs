defmodule OpenCagexTest do
  use ExUnit.Case
  doctest OpenCagex

  @api_key System.get_env("OPEN_CAGE_API_KEY")

  setup_all do
    assert(@api_key != nil)

    OpenCagex.set_api_key(@api_key)
  end

  describe "when given a latitude and longitude" do
    test "reverses the coordinates and returns a formated address" do
      expected_result = {:ok, "Moog, Carrer de l'Arc del Teatre, 3, 08001 Barcelona, Spain"}
      assert expected_result == OpenCagex.reverse(41.3780845, 2.1751182)
    end
  end

  describe "when given a place name" do
    test "returns a geocode" do
      expected_result = {:ok, %{"lat" => 41.3778504, "lng" => 2.1778608}}
      assert expected_result == OpenCagex.geocode("Passatge de la Pau, Barcelona")
    end
  end
end
