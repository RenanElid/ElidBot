defmodule ElidBot.Commands.Palavra do
  alias Nostrum.Api.Message
  require Logger

  @url "https://api.dicionario-aberto.net/random"

  def run(msg) do
    case HTTPoison.get(@url) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"word" => palavra}} ->

            Message.create(msg.channel_id, "📘 **Palavra aleatória:** #{palavra}")

          _ ->
            Message.create(msg.channel_id, "Erro ao interpretar a palavra da API.")

        end

      {:error, _reason} ->
        Message.create(msg.channel_id, "Não consegui acessar a API de palavras no momento.")
    end
  end
end
