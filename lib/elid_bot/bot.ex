defmodule ElidBot.Bot do
  use Nostrum.Consumer

  def handle_event(event) do
    ElidBot.Router.handle(event)
  end
end
