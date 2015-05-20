#!/usr/bin/ruby

require 'sqlite3'

database = SQLite3::Database.open "db/serial_parser_storage_test.sqlite"
database.execute("DELETE FROM playground")

database.transaction do |db|
  sql = db.prepare "INSERT INTO [playground] (id, sensor_id, pressure_value, time_stamp) VALUES (?, ?, ?, strftime('%Y-%m-%d %H:%M:%f'));"
  File.foreach('./lib/serial_files/test_serial_raw_80_seconds.txt').first(50).each do |line|
    temp_arr = line.split(':')
    sql.execute(1, temp_arr[0].hex + 1, temp_arr[1].hex + 1)
  end

  File.foreach('./lib/serial_files/test_serial_raw_15_seconds.txt').first(50).each do |line|
    temp_arr = line.split(':')
    sql.execute(2, temp_arr[0].hex + 1, temp_arr[1].hex + 1)
  end

end
