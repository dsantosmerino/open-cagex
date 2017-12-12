defmodule OpenCagex.ParserTest do
  use ExUnit.Case
  doctest OpenCagex.Parser

  describe "formatted_address/1" do
    test "returns value when results are present" do
      input = %{"results" => [%{"formatted" => true}]}

      assert {:ok, true} = OpenCagex.Parser.formatted_address(input)
    end

    test "returns when there are no results" do
      input = %{"results" => []}

      assert {:ok, nil} = OpenCagex.Parser.formatted_address(input)
    end
  end

  describe "geocode/1" do
    test "returns value when results are present" do
      input = %{"results" => [%{"geometry" => true}]}

      assert {:ok, true} = OpenCagex.Parser.geocode(input)
    end

    test "returns when there are no results" do
      input = %{"results" => []}

      assert {:ok, nil} = OpenCagex.Parser.geocode(input)
    end
  end
end
