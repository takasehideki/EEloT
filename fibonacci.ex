"""
This source is written by takatoh on his blog
See following link:
http://blog.panicblanket.com/archives/3450
"""
defmodule Fibonacci do

  def fib(n), do: IO.inspect fib_iter(0, 1, n, 1)

  defp fib_iter(_, _, n, i) when i > n, do: []
  defp fib_iter(a, b, n, i),            do: [a | fib_iter(b, a + b, n, i + 1)]

end
