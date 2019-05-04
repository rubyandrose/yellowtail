#!/usr/bin/env bash

brew_bundle() {
  brew bundle
}

install_bundle() {
  rbenv which bundler
  if ! [ $? -eq 0 ]; then
    gem install bundler -v 1.13.6
  fi
}

install_gems() {
  bundle check || bundle install
}

setup_rbenv() {
  task_inform "Setting up rbenv"

  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  if [ ! -d "$HOME/.rbenv/versions/2.6.0" ]; then
    subtask_exec "Install ruby 2.6.0" rbenv install 2.6.0
  fi

  if [ ! -f "$HOME/.rbenv/version" ]; then
    subtask_exec "Setting global ruby version to 2.6.0" rbenv global 2.6.0
  fi
}

setup_postgresql() {
  task_inform "Setting up PostgreSQL"
  export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH" # This is necessary b/c the postgresql binaries aren't yet in the user's $PATH

  while ! (pg_isready -q)
  do
    subtask_inform "Waiting for PostgreSQL to start up..."
    sleep 5
    ((seconds_waited+=5))

    if ((seconds_waited >= 60)); then
      subtask_warn "Waited for more than 60 seconds, moving on. PostgreSQL may not have started up correctly. Please investigate and try again."
      return
    fi
  done

  if ! (psql "$(whoami)" --command="SELECT version();" >/dev/null 2>&1); then
    subtask_exec "Creating PSQL database $(whoami)" psql postgres -c "\"create database $(whoami);\""
  fi
}

restart_services() {
  task_inform "Starting services"
  subtask_exec "Restarting PostgreSQL" brew services restart 'postgresql@9.6'
}

install_homebrew() {
  # Install homebrew if we don't have it already
  if ! command -v brew > /dev/null 2>&1; then
    task_inform "Installing Homebrew"

    set -e

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # shellcheck disable=2016
    append_to_rcfile 'export PATH="/usr/local/bin:$PATH"'

    export PATH="/usr/local/bin:$PATH"

    set +e
  else
    subtask_exec "Brew update" brew update
  fi
}

cd "$(dirname "$0")/.." || exit

source script/helpers.sh

install_homebrew && \
brew_bundle && \
setup_rbenv && \
setup_postgresql && \
restart_services && \

task_inform "Bootstrapping Dependencies..."

subtask_exec "Installing Ruby Version" rbenv install -s "$(cat .ruby-version)"

subtask_exec "Installing Bundler" install_bundle

subtask_exec "Installing Gem dependencies" install_gems

echo -e "🎉 ${GREEN}Bootstrapping is complete.${CLEARCOLOR}"
