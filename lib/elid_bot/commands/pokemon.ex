defmodule ElidBot.Commands.Pokemon do
  alias Nostrum.Api.Message

  def run(msg) do
    id = :rand.uniform(151)
    url = "https://pokeapi.co/api/v2/pokemon/#{id}"

    case HTTPoison.get(url) do
      {:ok, %{body: body}} ->
        {:ok, data} = Jason.decode(body)

        name = data["name"]
        sprite = data["sprites"]["front_default"]

        Message.create(msg.channel_id, "#{String.capitalize(name)}\n#{sprite}")

      _ ->
        Message.create(msg.channel_id, "Não consegui acessar a API de Pokémon.")
    end
  end
end
