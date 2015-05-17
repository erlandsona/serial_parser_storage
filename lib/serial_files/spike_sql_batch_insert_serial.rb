#!/usr/bin/ruby

require 'sqlite3'
require 'serialport'

begin

  sp = SerialPort.new('/dev/tty.usbmodemfa141')
  session_length = Time.now + 1
  sync = false

  database = SQLite3::Database.open "db/serial_parser_storage_test.sqlite"
  database.execute("DELETE FROM session")


  database.transaction do |db|
    sql = db.prepare "INSERT INTO [session] (ids, sensor_ids, pressure_values, time_stamps) VALUES (?, ?, ?, strftime('%Y-%m-%d %H:%M:%f'));"
    sp.each_line do |line|
      break if Time.now > session_length
      temp_arr = line[/\w+:\s?\w+/].gsub(/\s/,'').split(':')
      if temp_arr[0].to_i == 0
        sync = true
      end
      if sync
        sql.execute(1, temp_arr[0].to_i(16) + 1, temp_arr[1].to_i(16) + 1)
      end
    end
  end

rescue SQLite3::Exception => e

  puts "Exception occurred"
  puts e
  database.rollback

ensure

  sql.close if sql
  database.close if database
  sp.close if sp

end
