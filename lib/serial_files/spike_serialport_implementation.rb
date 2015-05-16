sp = SerialPort.new('/dev/tty.usbmodemfa141')

# session_length is the number of seconds to record the serial stream.
session_length = Time.now + 1 #Currently 1 is a magic num for 1 seconds

sp.each_line do |line|
  break if Time.now > session_length
  print line
end
