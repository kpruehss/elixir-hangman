defmodule Dictionary do
  def load_wordlist do
    contents = File.read!("assets/words.txt")
    list = String.split(contents, ~r/\n/)
  end
end
