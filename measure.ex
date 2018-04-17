defmodule Measure do
  @module_list [[LeibnizFormula, :calc, []], 
                [FibonacciSimple, :fib, [100000]]]
  #@module_list [[Fibonacci, :fib, [100000]]]

  def start do
    IO.puts "Measurement start.\n"
    for [module,func,arg] <- @module_list do
      IO.puts "#{module}, #{func}, #{inspect(arg)}"
      #{time, ret} = :timer.tc(module, func, arg)
      {time, _} = :timer.tc(module, func, arg)
      IO.puts "\ntime\: #{time/1000} ms"
      #IO.inspect "ret \: #{ret}"
      IO.puts "----------"
    end
  end
end

Measure.start
