#
# Check whether Elixir has been installed
#
if [ $# -eq 0 ] && which elixir >/dev/null 2>&1; then
  echo "Info: Elixir has been installed on your system."
  echo ""
  echo "$ elixir --version"
  elixir --version
  exit 0
fi

#
# Detect OS
#
if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  issue="$(cut -f -1 -d ' ' /etc/issue)"
  if [ ${issue} = 'Raspbian' ]; then
    OS='Raspbian'
  elif [ ${issue} = 'Ubuntu' ]; then
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

#
# Clean up Elixir
#
if [ $# -eq 1 ] && [ $1 == 'clean' ]; then
  echo "Info: Clean up Elixir on your ${OS} system."
  if [ "${OS}" == 'Mac' ]; then
    if which brew >/dev/null 2>&1; then
      echo "$ brew uninstall elixir"
      brew uninstall elixir
    elif which port >/dev/null 2>&1; then
      echo "$ sudo port uninstall elixir"
      sudo port uninstall elixir
    else
      echo "Error: You should install brew or port on Mac."
      exit 1
    fi
  elif [ "${OS}" == 'Raspbian' ]; then
    echo "Info: Uninstall Elixir"
    sudo apt remove elixir
  elif [ "${OS}" == 'Ubuntu' ]; then
    echo "Info: Uninstall Elixir"
    sudo apt-get remove elixir
  else
    echo "Error: Your platform ($(uname -a)) is not supported."
    exit 1
  fi
  exit 0
fi

#
# Install Elixir by Package manager
#
if [ $# -eq 0 ]; then
  echo "Info: Elixir will be installed on your ${OS} system by Package manager."
  echo "Warn: command will be done by sudo."

  if [ "${OS}" == 'Mac' ]; then
    if which brew >/dev/null 2>&1; then
      echo "$ brew install elixir"
      brew install elixir
    elif which port >/dev/null 2>&1; then
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
    rm -f erlang-solutions_1.0_all.deb

  else
    echo "Error: Your platform ($(uname -a)) is not supported."
    exit 1
  fi
fi

#
# Build and install Elixir from source code
#
if [ $# -eq 1 ] && [ $1 == 'source' ]; then
  echo "Info: Elixir will be built and installed on your ${OS} system from source."
  echo "Warn: Some command will be done by sudo."

  if [ "${OS}" == 'Mac' ]; then
    ;
  elif [ "${OS}" == 'Raspbian' ]; then
    echo "Info: Install Erlang environment"
    sudo apt-get install erlang-nox erlang-dev

  elif [ "${OS}" == 'Ubuntu' ]; then
    echo "Info: Install Erlang environment"
    sudo apt-get install erlang-nox erlang-dev
    sudo apt-get install esl-erlang

  else
    echo "Error: Your platform ($(uname -a)) is not supported."
    exit 1
  fi

  git clone https://github.com/elixir-lang/elixir.git ../elixir_src
  cd ../elixir_src
  git checkout refs/tags/v1.6.1
  echo "$ make clean test"
  make clean test
  echo "$ sudo make install"
  sudo make install

fi

#
# Check installation
#
if which elixir >/dev/null 2>&1; then
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
