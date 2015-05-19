require 'command_line_reporter'

class Table

  include CommandLineReporter

  def generate
    suppress_output

    table(:border => true) do
      1.times do #number of rows.times do
        row do
          i = 0
          4.times do #number of columns.times do
            i += 10
            column('', :align => "center", :width => 20)
          end
        end
      end
    end

    return capture_output
  end

end
