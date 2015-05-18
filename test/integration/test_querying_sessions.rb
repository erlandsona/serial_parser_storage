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
    # create_scenario("eat tiger meat")
    # create_scenario("swallow a pencil")
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2" # list all scenarios
      expected_output << "1. eat tiger meat\n"
      expected_output << "2. swallow a pencil\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
