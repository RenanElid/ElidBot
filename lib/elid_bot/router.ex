defmodule ElidBot.Router do
  alias ElidBot.Commands.{Piada, Pokemon, Filme, Frase, Fato, Gato, Palavra}

  def handle({:MESSAGE_CREATE, msg, _ws_state}) do
    case msg.content do
      "!piada" -> Piada.run(msg)
      "!pokemon" -> Pokemon.run(msg)
      "!filme" -> Filme.run(msg)
      "!frase" -> Frase.run(msg)
      "!fato" -> Fato.run(msg)
      "!gato" -> Gato.run(msg)
      "!palavra" -> Palavra.run(msg)
      _ -> :ignore
    end
  end

  def handle(_), do: :noop
end
