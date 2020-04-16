defmodule Dictionary do
  # Pick a random word from the word list
  def random_word do
    Enum.random(load_word_list())
  end

  # Load wordl list from file
  def load_word_list do
    contents = File.read!("assets/words.txt")
    list = String.split(contents, ~r/\n/)
  end
end
