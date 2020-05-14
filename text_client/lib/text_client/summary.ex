defmodule TextClient.Summary do

  def display(game = %{ tally: tally, game_service: gs}) do
    IO.puts [
      "\n",
      "Word so far:  #{Enum.join(tally.letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Letters used: #{Enum.join(gs.used, " ")}\n"
    ]
    game
  end
  
end
