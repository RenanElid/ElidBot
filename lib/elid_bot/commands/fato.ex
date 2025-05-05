defmodule ElidBot.Commands.Fato do
  @moduledoc false
  alias Nostrum.Api.Message
  require Logger

  @url "https://uselessfacts.jsph.pl/api/v2/facts/random?language=en"

  def run(msg) do
    case HTTPoison.get(@url) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"text" => text}} ->
            Message.create(msg.channel_id, "📚 **Fato aleatório:**\n#{text}")

          _ ->
            Message.create(msg.channel_id, "Erro ao entender a resposta da API de fatos.")
        end

      {:error, _reason} ->
        Message.create(msg.channel_id, "Não consegui acessar a API de fatos no momento.")
    end
  end
end
