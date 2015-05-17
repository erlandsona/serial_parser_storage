sp = SerialPort.new('/dev/tty.usbmodemfa141')

session_length = Time.now + 0.1

sync = false

sp.each_line do |line|
  break if Time.now > session_length
  parsed_kvp_arr = line[/\w+:\s?\w+/].gsub(/\s/,'').split(':')
  if parsed_kvp_arr[0].to_i == 0
    sync = true
  end
  if sync
    puts parsed_kvp_arr.to_s
  end
end

sp.close

