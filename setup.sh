if [ $# -eq 1 ]; then
  if [ $1 == 'clean' ]; then
    echo "Info: Clean up beam files and git dirs."
    rm -f Elixir.*.beam
    rm -rf elixir_agg_csv
    rm -rf fukuokaex5_csv
    rm -rf phoenix-showdown
    exit 0
  elif [ $1 == 'ex' ]; then
    echo "Info: Compile .ex to beam files"
    elixirc leibniz_formula.ex
    elixirc fibonacci_simple.ex
    elixirc fibonacci_process.ex
    elixirc measure.ex
    exit 0
  else
    echo "Error: Invalid argument."
    exit 1
  fi
fi

elixirc leibniz_formula.ex
elixirc fibonacci_simple.ex
elixirc fibonacci_process.ex
elixirc measure.ex

git clone https://github.com/enpedasi/elixir_agg_csv.git
cd elixir_agg_csv/
mix deps.get
mix compile
cd ../

git clone https://github.com/enpedasi/fukuokaex5_csv.git
7z x fukuokaex5_csv/test_300000.7z -oelixir_agg_csv/
7z x fukuokaex5_csv/test_3_000_000.7z -oelixir_agg_csv/

git clone https://github.com/takasehideki/phoenix-showdown.git
cd phoenix-showdown/phoenix/benchmarker
mix deps.get
mix deps.compile
cd ../
