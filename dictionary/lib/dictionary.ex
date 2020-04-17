defmodule Dictionary do
  def random_word do
    load_word_list()
    |> Enum.random()
  end

  def load_word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
