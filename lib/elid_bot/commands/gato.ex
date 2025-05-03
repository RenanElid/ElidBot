defmodule ElidBot.Commands.Gato do
  @moduledoc false
  alias Nostrum.Api
  require Logger

  @url "https://api.thecatapi.com/v1/images/search"

  def run(msg) do
    case HTTPoison.get(@url) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, [%{"url" => image_url}]} ->
            Api.create_message(msg.channel_id, image_url)

          _ ->
            Api.create_message(msg.channel_id, "Erro ao interpretar a imagem do gato.")
        end

      {:error, _reason} ->
        Api.create_message(msg.channel_id, "Não consegui acessar a API de gatos no momento.")
    end
  end
end
