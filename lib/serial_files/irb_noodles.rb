# This will parse and add values to the database from a test file with serial data inside.
File.foreach('./lib/serial_files/test_serial_raw.txt').first(10).each do |line|
  temp_arr = line.chomp.gsub(/\s/, '').split(':')
  add_row(1, temp_arr[0].to_i(16) + 1, temp_arr[1].to_i(16) + 1)
end


# This will parse and add values to the database from a test file with raw serial data inside. Preparing to add Serial Gem.
File.foreach('./lib/serial_files/test_serial_raw_15_seconds.txt') do |line|
  temp_arr = line.chomp.gsub(/\s/, '').split(':')
  add_row(1, temp_arr[0].to_i(16) + 1, temp_arr[1].to_i(16) + 1)
end

