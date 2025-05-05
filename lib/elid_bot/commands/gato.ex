defmodule ElidBot.Commands.Gato do
  @moduledoc false
  alias Nostrum.Api.Message
  require Logger

  @url "https://api.thecatapi.com/v1/images/search"

  def run(msg) do
    case HTTPoison.get(@url) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, [%{"url" => image_url}]} ->
            Message.create(msg.channel_id, image_url)

          _ ->
            Message.create(msg.channel_id, "Erro ao interpretar a imagem do gato.")
        end

      {:error, _reason} ->
        Message.create(msg.channel_id, "Não consegui acessar a API de gatos no momento.")
    end
  end
end
