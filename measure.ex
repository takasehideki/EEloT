defmodule Measure do
  @module_list [[LeibnizFormula, :calc, [100_000_000]],
                [FibonacciSimple, :fib, [100000]],
                [Scheduler, :run, [10, FibSolver, :fib, [37,37,37,37,37,37]]]]

  def allex do
    IO.puts "Measurement start.\n"
    for [module,func,arg] <- @module_list do
      IO.puts "#{module}, #{func}, #{inspect(arg)}"
      IO.inspect {time, _} = :timer.tc(module, func, arg)
      IO.puts "\ntime\: #{time/(1000*1000)} second"
      IO.puts "----------"
    end
  end

  @lf_arg [10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000, 100_000_000]
  def leibniz do
    IO.puts "Measurement of LeibnizFormula start.\n"
    IO.puts "arg,time[us]"
    Enum.each(@lf_arg, fn(i) ->
      {time, _} = :timer.tc(LeibnizFormula, :calc, [i])
      IO.puts "#{i},#{time}"
    end)
  end

  @fs_arg [10, 100, 200, 500, 1_000, 2_000, 5_000, 10_000, 20_000, 50_000, 100_000]
  def fibsimple do
    IO.puts "Measurement of FibonacciSimple start.\n"
    IO.puts "arg,time[us]"
    Enum.each(@fs_arg, fn(i) ->
      {time, _} = :timer.tc(FibonacciSimple, :fib, [i])
      IO.puts "#{i},#{time}"
    end)
  end

  @fm_arg [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
  def fibmulti do
    IO.puts "Measurement of FibSolver start.\n"
    IO.puts "arg,time[us]"
    Enum.each(@fm_arg, fn(i) ->
      {time, _} = :timer.tc(Scheduler, :run, [i, FibSolver, :fib, [37,37,37,37,37,37]])
      IO.puts "#{i},#{time}"
    end)
  end
end
