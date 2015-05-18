require 'command_line_reporter'

class TableView
  include CommandLineReporter

  def run

    table(:border => true) do

      row :header => true do
       column('NAME', :width => 20)
       column('ADDRESS', :width => 40, :align => 'center')
       column('CITY', :width => 30, :align => 'right')
      end

      row :color => 'magenta' do
       column('Caesar')
       column('1 Appian Way')
       column('Rome')
      end

      row :color => 'magenta' do
       column('Richard Feynman')
       column('1 Golden Gate')
       column('Quantum Field')
      end

    end

  end

end
