require 'command_line_reporter'

class Table

  include CommandLineReporter

  def generate(id: nil, sensor_id: nil, pressure_value: nil)
    readings = Reading.find(id: id, sensor_id: sensor_id, pressure_value: pressure_value)
    head = {:id => "Session #", :sensor_id => "Sensor ID",
            :pressure_value => "Pressure Value", :time_stamp => "Time Stamp"}

    suppress_output

    table(:border => true) do

      # Readings are returned in order from Oldest (at top) to newest (at bottom)
      # to display correctly in a terminal.

      readings.each do |reading|
        row do
          column(reading.id, :align => "left", :width => head[:id].length)
          column(reading.sensor_id, :align => "left", :width => head[:sensor_id].length)
          column(reading.pressure_value, :align => "left", :width => head[:pressure_value].length)
          column(reading.time_stamp, :align => "center", :width => reading.time_stamp.length)
        end
      end

      #Heading gets printed at bottom of output

      row :bold => true, :color => "magenta" do
        column(head[:id], :align => "center", :width => head[:id].length)
        column(head[:sensor_id], :align => "center", :width => head[:sensor_id].length)
        column(head[:pressure_value], :align => "center", :width => head[:pressure_value].length)
        column(head[:time_stamp], :align => "center", :width => head[:time_stamp].length)
      end

    end

    return capture_output
  end

end
