ENV["TEST"] = "true"
require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require_relative '../lib/environment'

Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'
class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM readings;")
  end
end

def record_test_readings

    Database.transaction do
      sql = Database.prepare("INSERT INTO [readings] (id, sensor_id, pressure_value, time_stamp) VALUES (?, ?, ?, strftime('%Y-%m-%d %H:%M:%f'));")

      File.foreach('./lib/serial_files/test_serial_raw_80_seconds.txt').first(10).each do |line|
        temp_arr = line.split(':')
        sql.execute(1, temp_arr[0].hex + 1, temp_arr[1].hex + 1)
      end

      File.foreach('./lib/serial_files/test_serial_raw_15_seconds.txt').first(10).each do |line|
        temp_arr = line.split(':')
        sql.execute(2, temp_arr[0].hex + 1, temp_arr[1].hex + 1)
      end

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
