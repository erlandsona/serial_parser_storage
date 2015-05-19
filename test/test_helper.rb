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

def record_test_sessions

    Database.transaction do |db|
      sql = Database.prepare("INSERT INTO [sessions] (id, sensor_id, pressure_value, time_stamp) VALUES (?, ?, ?, strftime('%Y-%m-%d %H:%M:%f'));")

      File.foreach('./lib/serial_files/test_serial_raw_80_seconds.txt').first(100).each do |line|
        temp_arr = line.split(':')
        sql.execute(1, temp_arr[0].to_i(16) + 1, temp_arr[1].to_i(16) + 1)
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
