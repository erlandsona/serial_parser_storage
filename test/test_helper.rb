require 'rubygems'
require 'bundler/setup'
require "minitest/reporters"

Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }
ENV["TEST"] = "true"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'
class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM sessions;")
  end
end

def main_menu
  "1. Start a session\n" +
  "2. Query a session\n" +
  "3. Exit\n"
end

def error
  "Please try again without any arguments...\n" +
  "Try \"./serial_parser_storage\"\n"
end
