defmodule Cache do

  @doc """
  Start the cache, run the supplied function, then stop the cache.
  """
  def run(body) do
    {:ok, pid} = Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
    result = body.(pid)
    Agent.stop(pid)
    result
  end

  def lookup(cache, n, if_not_found) do
    Agent.get(cache, fn map -> map[n] end)
    |> complete_if_not_found(cache, n, if_not_found)
  end

  defp complete_if_not_found(nil, cache, n, if_not_found) do
    if_not_found.()
    |> set(cache, n)
  end

  defp complete_if_not_found(value, _cache, _n, _if_not_found) do
    value
  end

  defp set(val, cache, n) do
    Agent.get_and_update(cache, fn map ->
      {val, Map.put(map, n, val)}
    end)
  end
end

defmodule CachedFib do
  def fib(n) do
    Cache.run(fn cache -> cached_fib(n, cache)
    end)
  end

  defp cached_fib(n, cache) do
    Cache.lookup(cache, n, fn ->
      cached_fib(n-2, cache) + cached_fib(n-1, cache)
    end)
  end
end
