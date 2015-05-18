require_relative '../test_helper'

class QueryingSessions < Minitest::Test
  def test_listing_no_scenarios
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "No sessions found.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_listing_multiple_scenarios
    record_sessions
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2" # list all sessions
      expected_output += <<EOS
┏━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ \e[1mNAME                \e[0m ┃ \e[1m                 ADDRESS                \e[0m ┃ \e[1m                          CITY\e[0m ┃
┣━━━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃ \e[35mCaesar              \e[0m ┃ \e[35m              1 Appian Way              \e[0m ┃ \e[35m                          Rome\e[0m ┃
┣━━━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃ \e[35mRichard Feynman     \e[0m ┃ \e[35m              1 Golden Gate             \e[0m ┃ \e[35m                 Quantum Field\e[0m ┃
┗━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
EOS
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
