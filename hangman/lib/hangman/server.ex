defmodule Hangman.Server do

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

end
