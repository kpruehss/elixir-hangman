defmodule Dictionary do
  def random_word do
    load_word_list()
    |> Enum.random()
  end

  def load_word_list do
    "assets/words.txt"
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
