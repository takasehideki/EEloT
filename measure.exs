defmodule Measure do
  @module_list [[LeibnizFormula, :calc, [100_000_000]],
                [FibonacciSimple, :fib, [100000]],
                [Scheduler, :run, [10, FibSolver, :fib, [37,37,37,37,37,37]]]]

  def all do
    IO.puts "Measurement start.\n"
    for [module,func,arg] <- @module_list do
      IO.puts "#{module}, #{func}, #{inspect(arg)}"
      IO.inspect {time, _} = :timer.tc(module, func, arg)
      IO.puts "\ntime\: #{time/(1000*1000)} second"
      IO.puts "----------"
    end
  end
end
