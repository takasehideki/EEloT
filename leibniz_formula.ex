#---
# This source is written by @twinbee on Qiita
# See following link:
# https://qiita.com/hanada/items/c91788bcac2a40f1bb05#comment-b69e6585e1b86b5c03f7
#---
defmodule LeibnizFormula do
  def calc(n) do
    s = 0..n
        |> Enum.reduce( 0, fn (x, acc) -> acc + (:math.pow(-1, x) / (2*x + 1)) end )
    s*4
    #IO.puts s
  end
end
