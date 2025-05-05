defmodule ElidBot.Commands.Frase do
  alias Nostrum.Api.Message
  require Logger

  @url "https://zenquotes.io/api/random"

  def run(msg) do
    case HTTPoison.get(@url, [], follow_redirect: true) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, [%{"q" => quote, "a" => author}]} ->
            mensagem = "> _#{quote}_\n**– #{author}**"
            Message.create(msg.channel_id, mensagem)

          _ ->
            Message.create(msg.channel_id, "Erro ao interpretar a resposta da API de frases.")
        end

      {:error, _reason} ->
        Message.create(msg.channel_id, "Não consegui acessar a API de frases no momento.")
    end
  end
end
