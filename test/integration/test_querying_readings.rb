require_relative '../test_helper'

class QueryingSessions < Minitest::Test

  def test_listing_no_scenarios
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "No results were returned by your query...\n"
      expected_output += <<-TABLE
┏━━━━━━━━━━━┳━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ \e[1m\e[35mSession #\e[0m\e[0m ┃ \e[1m\e[35mSensor ID\e[0m\e[0m ┃ \e[1m\e[35mPressure Value\e[0m\e[0m ┃ \e[1m\e[35mTime Stamp\e[0m\e[0m ┃
┗━━━━━━━━━━━┻━━━━━━━━━━━┻━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━┛
      TABLE
      expected_output << main_menu
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end
