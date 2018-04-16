if type elixir >/dev/null 2>&1; then
  echo "Info: Elixir has been installed on your system."
  echo ""
  echo "$ elixir --version"
  elixir --version
  exit 0
fi

if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  issue="$(cat /etc/issue)"
  if [ $(echo ${issue} | grep -e "Raspbian") ]; then
    OS='Raspbian'
  elif [ $(echo ${issue} | grep -e "Ubuntu") ]; then
    OS='Ubuntu'
  else
    echo "Error: Your OS (${issue}) is not supported."
    exit 1
  fi
#elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
#  OS='Cygwin'
else
  echo "Error: Your platform ($(uname -a)) is not supported."
  exit 1
fi


echo "Info: The script will install Elixir on your system."
echo "Info: Some command will be done by sudo."

if [ "${OS}" == 'Mac' ]; then
  if type brew >/dev/null 2>&1; then
    echo "$ brew install elixir"
    brew install elixir
  elif type port >/dev/null 2>&1; then
    echo "$ sudo port install elixir"
    sudo port install elixir
  else
    echo "Error: You should install brew or port on Mac."
    exit 1
  fi
elif [ "${OS}" == 'Raspbian' ]; then
  echo "Info: Get Erlang key"  
  echo "deb https://packages.erlang-solutions.com/debian stretch contrib" | sudo tee /etc/apt/sources.list.d/erlang-solutions.list
  wget https://packages.erlang-solutions.com/debian/erlang_solutions.asc
  sudo apt-key add erlang_solutions.asc
  echo "Info: Install Elixir"
  sudo apt update
  sudo apt install elixir

elif [ "${OS}" == 'Ubuntu' ]; then
  echo "Info: Add Erlang Solutions repo"
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
  sudo apt-get update
  echo "Info: Install the Erlang/OTP platform and all of its applications"
  sudo apt-get install esl-erlang
  echo "Info: Install Elixir"
  sudo apt-get install elixir
fi

echo "$(uname) ${OS}"
  
if type elixir >/dev/null 2>&1; then
  echo ""
  echo "Info: Elixir can be successfully installed."
  echo ""
  echo "$ elixir --version"
  elixir --version
  exit 0
else
  echo "Error: Elixir cannot be installed."
  exit 1
fi
