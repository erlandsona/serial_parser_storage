# #!/usr/bin/ruby

# require 'sqlite3'
# require 'serialport'

# sp = SerialPort.new('/dev/tty.usbmodemfa141')
# session_length = Time.now + 15
# sync = false

# database = SQLite3::Database.open "db/serial_parser_storage_test.sqlite"
# database.execute("DELETE FROM sessions")


# database.transaction do |db|
#   sql = db.prepare "INSERT INTO [sessions] (id, sensor_id, pressure_value, time_stamp) VALUES (?, ?, ?, strftime('%Y-%m-%d %H:%M:%f'));"
#   sp.each_line do |line|
#     break if Time.now > session_length
#     temp_arr = line[/\w+:\s?\w+/].gsub(/\s/,'').split(':')
#     if temp_arr[0].to_i == 0
#       sync = true
#     end
#     if sync
#       sql.execute(1, temp_arr[0].hex + 1, temp_arr[1].hex + 1)
#     end
#   end
# end

# sp.close if sp

