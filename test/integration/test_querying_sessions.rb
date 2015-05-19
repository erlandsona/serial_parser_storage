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
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ Stuff and more Stuffs Variable ┃ Stuff and more Stuffs Variable ┃ Stuff and more Stuffs Variable ┃
┃            of course           ┃            of course           ┃            of course           ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃ Stuff and more Stuffs Variable ┃ Stuff and more Stuffs Variable ┃ Stuff and more Stuffs Variable ┃
┃            of course           ┃            of course           ┃            of course           ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
EOS
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
