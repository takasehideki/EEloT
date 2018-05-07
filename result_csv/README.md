# CSV results of EEloT

This directory includes CSV results of `*.ex` benchmark apps when varying their argument.

- leibniz.csv: Evaluation result for `leibniz_formula.ex` when varying the upper limit of Leibniz from 10 to 100_000_000
- fibsimple.csv: Evaluation result for `fibonacci_simple.ex` when varying the number of Fibonacci from 10 to 100_000
- fibmulti.csv: Evaluation result for `fibonacci_process.ex` when varying the number of parallel process from 1 to 16

To execute apps, you put following commands on the top directory.

```
$ elixirc measure.ex
$ elixir -e Measure.leibniz
$ elixir -e Measure.fibsimple
$ elixir -e Measure.fibmulti
```
