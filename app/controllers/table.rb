require 'command_line_reporter'

class Table

  include CommandLineReporter

  def generate(id: nil, sensor_id: nil, pressure_value: nil)
    session = Session.find(id: id, sensor_id: sensor_id, pressure_value: pressure_value)
    head = {:id => "Session #", :sensor_id => "Sensor ID",
            :pressure_value => "Pressure Value", :time_stamp => "Time Stamp"}

    suppress_output

    table(:border => true) do

      row :header => true, :bold => true, :color => "magenta" do
        column(head[:id], :align => "center", :width => head[:id].length)
        column(head[:sensor_id], :align => "center", :width => head[:sensor_id].length)
        column(head[:pressure_value], :align => "center", :width => head[:pressure_value].length)
        column(head[:time_stamp], :align => "center", :width => head[:time_stamp].length + 15)
      end

      session.each do |row|
        row do
          row.each do |column|
            column(column, :align => "center")
          end
        end
      end

    end

    return capture_output
  end

end
