# Autobot GPT
[![Maintainability](https://api.codeclimate.com/v1/badges/0be3a49ca599e9699ea7/maintainability)](https://codeclimate.com/github/jeffdevine/autobot-gpt/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/0be3a49ca599e9699ea7/test_coverage)](https://codeclimate.com/github/jeffdevine/autobot-gpt/test_coverage)

Autobot GPT is a ruby port of Adam McMurchie's [Automator](https://github.com/murchie85/GPT_AUTOMATE). Automator uses OpenAI's GPT models to decompose software requests into small deliverables and generate code for each.

## What can Autobot do?
It is early days, and it currently mimics the functionality of [Automator](https://github.com/murchie85/GPT_AUTOMATE). `Autobot` will ask you to describe your requirements and determine if it can use [OpenAI](https://openai.com) models to write software for your request.

# Environment Setup

## macOS

To install everything locally, you'll need the following:

* Ruby 3.1.x
* OpenAPI API Key

### Ruby
You can install and manage your rubies using any tool you want. The following describes how to manage it with [Homebrew](https://brew.sh) and [asdf](https://asdf-vm.com).

First, install [Homebrew](https://brew.sh):

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Next use, `homebrew` to install `asdf`:

```
brew install asdf
```

For zsh users (macOS default as of 10.5+), load `asdf` automatically by appending the following to your shell configuration (`~/.zshrc`):

```
echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
```

Clone the latest code from github

```
git clone git@github.com:jeffdevine/autobot-gpt.git
```

Change to the source directory

```
cd autobot-gpt
```

Run `bundle` to install the required gems:

```
bundle install
```

### Development Tools
To run the test suite, execute:

```
bundle exec rspec
```

To look for code and linting issues, run the following:

```
bundle exec rubocop
```
