require "rspec"
require "capybara"
require 'capybara/rspec'
require "pry"

require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.always_include_port = true
Capybara.app_host = 'http://localhost:8124'  # Any lvh.me domain resolves to localhost
Capybara.default_wait_time = 1

# RSpec.configure do |config|
#   # Capybara::SpecHelper.configure(config)

#   Capybara.javascript_driver = :poltergeist

#   Capybara.app_host = 'http://localhost:8124'


# end
