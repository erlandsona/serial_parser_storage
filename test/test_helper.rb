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
    Database.execute("DELETE FROM session;")
  end
end

def add_row(ids, sensor_ids, pressure_values)
  Database.execute(
    "INSERT INTO [session] (ids, sensor_ids, pressure_values, time_stamps)" +
    "VALUES (?, ?, ?, strftime('%Y-%m-%d %H:%M:%f'))",
    ids, sensor_ids, pressure_values)
end

def main_menu
  "1. Add a scenario\n2. List all session\n3. Exit\n"
end
