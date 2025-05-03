defmodule ElidBotTest do
  use ExUnit.Case
  doctest ElidBot

  test "greets the world" do
    assert ElidBot.hello() == :world
  end
end
