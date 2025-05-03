defmodule ElidBot.Commands.Fato do
  @moduledoc false
  alias Nostrum.Api
  require Logger

  @url "https://uselessfacts.jsph.pl/api/v2/facts/random?language=en"

  def run(msg) do
    case HTTPoison.get(@url) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"text" => text}} ->
            Api.create_message(msg.channel_id, "📚 **Fato aleatório:**\n#{text}")

          _ ->
            Api.create_message(msg.channel_id, "Erro ao entender a resposta da API de fatos.")
        end

      {:error, _reason} ->
        Api.create_message(msg.channel_id, "Não consegui acessar a API de fatos no momento.")
    end
  end
end
