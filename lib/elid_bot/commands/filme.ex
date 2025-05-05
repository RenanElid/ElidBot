defmodule ElidBot.Commands.Filme do
  @moduledoc false
  alias Nostrum.Api.Message
  require Logger

  @api_key "dc4cfcf038518a955270c2cc78774cdf"
  @url "https://api.themoviedb.org/3/movie/popular?language=pt-BR&api_key=#{@api_key}"

  def run(msg) do
    case HTTPoison.get(@url) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"results" => filmes}} when is_list(filmes) ->
            filme = Enum.random(filmes)
            titulo = filme["title"]
            descricao = filme["overview"]
            poster_url = "https://image.tmdb.org/t/p/w500#{filme["poster_path"]}"

            mensagem = "**#{titulo}**\n#{descricao}\n#{poster_url}"
            Message.create(msg.channel_id, mensagem)

          _ ->
            Message.create(msg.channel_id, "Erro ao entender a resposta da API de filmes.")
        end

      {:error, _reason} ->
        Message.create(msg.channel_id, "Não consegui acessar a API de filmes no momento.")
    end
  end
end
