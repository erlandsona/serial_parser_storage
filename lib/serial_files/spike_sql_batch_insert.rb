#!/usr/bin/ruby

require 'sqlite3'

begin

  database = SQLite3::Database.open "db/serial_parser_storage_test.sqlite"
  database.execute("DELETE FROM session")

  database.transaction do |db|
    sql = db.prepare "INSERT INTO [session] (ids, sensor_ids, pressure_values, time_stamps) VALUES (?, ?, ?, strftime('%Y-%m-%d %H:%M:%f'));"
    File.foreach('./lib/serial_files/test_serial_raw_80_seconds.txt') do |line|
      temp_arr = line.split(':')
      sql.execute(1, temp_arr[0].to_i(16) + 1, temp_arr[1].to_i(16) + 1)
    end
  end

rescue SQLite3::Exception => e

    puts "Exception occurred"
    puts e
    database.rollback

ensure

    sql.close if sql
    database.close if database

end
