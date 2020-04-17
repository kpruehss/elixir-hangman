defmodule Hangman do
  alias Hangman.Game

  defdelegate init_game(), to: Game, as: :new_game
end
