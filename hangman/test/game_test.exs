defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert String.match?(~s/#{game.letters}/, ~r/^[a-z]/)
    assert length(game.letters) > 0
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "First/Second occurrence of letter is not/is already used " do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("puckers")
    game = Game.make_move(game, "p")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    moves = [
      {"p", :good_guess},
      {"u", :good_guess},
      {"c", :good_guess},
      {"k", :good_guess},
      {"e", :good_guess},
      {"r", :good_guess},
      {"s", :won}
    ]

    game = Game.new_game("puckers")

    fun = fn {guess, state}, game ->
      game = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end

    Enum.reduce(moves, game, fun)
  end

  test "bad guess is recognized" do
    game = Game.new_game("puckers")
    game = Game.make_move(game, "t")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "7 wrong guesses is a lost game" do
    moves = [
      {"a", :bad_guess, 6},
      {"b", :bad_guess, 5},
      {"d", :bad_guess, 4},
      {"f", :bad_guess, 3},
      {"t", :bad_guess, 2},
      {"y", :bad_guess, 1},
      {"z", :lost, 0}
    ]

    game = Game.new_game("w")

    fun = fn {guess, state, index}, game ->
      game = Game.make_move(game, guess)
      assert game.game_state == state

      assert game.turns_left == index
      game
    end

    Enum.reduce(moves, game, fun)
  end
end
