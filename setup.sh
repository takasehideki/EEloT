if [ $# -eq 1 ] && [ $1 == 'clean' ]; then
  echo "Clean up beam files and git dirs."
  rm -f Elixir.*.beam
  rm -rf elixir_agg_csv
  rm -rf fukuokaex5_csv
  rm -rf phoenix-showdown
  exit 0
fi

elixirc leibniz_formula.ex
elixirc fibonacci_simple.ex
elixirc fibonacci_process.ex

git clone https://github.com/enpedasi/elixir_agg_csv.git
git clone https://github.com/enpedasi/fukuokaex5_csv.git
cd elixir_agg_csv/
7z x ../fukuokaex5_csv/test_300000.7z
7z x ../fukuokaex5_csv/test_3_000_000.7z
mix deps.get
mix compile
cd ..

git clone https://github.com/mroth/phoenix-showdown.git
cd phoenix-showdown/phoenix/benchmarker
mix deps.get
mix deps.compile
