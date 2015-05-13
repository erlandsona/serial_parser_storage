require_relative '../test_helper'

class TestListingScenarios < Minitest::Test

  def test_listing_no_scenarios
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "No scenarios found. Add a scenario.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_listing_multiple_scenarios
    create_scenario("Eat tiger meat")
    create_scenario("Swallow a pencil")
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage manage', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2" # List all scenarios
      expected_output << "1. Eat tiger meat\n"
      expected_output << "2. Swallow a pencil\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
