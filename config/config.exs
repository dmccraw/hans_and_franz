# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :hans_and_franz, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:hans_and_franz, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
config :hans_and_franz, slack_token: System.get_env("HANS_AND_FRANZ_SLACK_TOKEN")

config :hans_and_franz,
  default_timezone:   "America/Denver", # timezone used
  office_hour_start:  9, # hour that messages should start
  office_hour_end:    16 # hour that messages should end

import_config "#{Mix.env}.exs"
