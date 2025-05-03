defmodule ElidBot.Commands.Piada do
  alias Nostrum.Api.Message

  def run(msg) do
    url = "https://v2.jokeapi.dev/joke/Any?lang=pt"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"type" => "single", "joke" => joke}} ->
            Message.create(msg.channel_id, joke)

          {:ok, %{"type" => "twopart", "setup" => setup, "delivery" => punchline}} ->
            Message.create(msg.channel_id, "#{setup}\n#{punchline}")

          _ ->
            Message.create(msg.channel_id, "Erro ao entender a piada.")
        end

      _ ->
        Message.create(msg.channel_id, "Não consegui acessar a nova API de piada.")
    end
  end
end
