require_relative '../test_helper'

class TestBasicUsage < Minitest::Test
  def test_minimum_arguments_required
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage') do |pipe|
      expected_output = "[Help] Run as: ./serial_parser_storage manage\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
