require 'serialport'

class Session

  def self.find(id: nil, sensor_id: nil, pressure_value: nil)
    statement = "SELECT * FROM sessions"
    arguments = {id: id, sensor_id: sensor_id, pressure_value: pressure_value}.reject{|k, v| v.nil?}
    unless arguments.empty?
      statement << " WHERE"
      statement << arguments.map { |key, val| " #{key.to_s}=#{val.to_s}" }.join(' AND')
    end
    statement << ";"
    Database.execute(statement)
  end

  def self.record(port: `ls /dev/tty.usb*`.chomp, time: 300) #time: 5 min default and can be stopped by pressing q at anytime.
    connection_message = "No such file or directory please connect your device."

    return connection_message if port.empty?

    serial = SerialPort.new(port)
    session_length = Time.now + time
    sync = false
    exit_string = "qQzZxXcC/\e\n\s\r\177\004"

    Database.transaction do
      sql = Database.prepare "INSERT INTO [sessions] (id, sensor_id, pressure_value, time_stamp) VALUES (?, ?, ?, strftime('%Y-%m-%d %H:%M:%f'));"
      serial.each_line do |line|
        break if Time.now > session_length #or exit_string.include?(read_char)
        temp_arr = line[/\w+:\s?\w+/].gsub(/\s/,'').split(':')
        if temp_arr[0].to_i == 0
          sync = true
        end
        if sync
          sql.execute(1, temp_arr[0].hex + 1, temp_arr[1].hex + 1)
        end
      end
    end

    serial.close if serial
    true

  end

  private

  def self.read_char

    begin

      old_state = `stty -g`
      system "stty raw -echo" # disable echoing and enable raw (not having to press enter)
      key = STDIN.getc.chr

      if(key == "\e") # gather next two characters of special keys
        extra_thread = Thread.new{
          key << STDIN.getc.chr
          key << STDIN.getc.chr
        }
        # wait just long enough for special keys to get swallowed
        extra_thread.join(0.00001)
        # kill thread so not-so-long special keys don't wait on getc
        extra_thread.kill
      end

    rescue => ex
      puts "#{ex.class}: #{ex.message}"
      puts ex.backtrace
    ensure
      system "stty #{old_state}" # restore previous state of stty
    end

    return key

  end

end

