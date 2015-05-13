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

  def test_manage_wrong_argument_given
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage blah') do |pipe|
      expected_output = "[Help] Run as: ./serial_parser_storage manage\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_multiple_arguments_given
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage manage blah') do |pipe|
      expected_output = "[Help] Run as: ./serial_parser_storage manage\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_argument_given_then_exit
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage manage', 'r+') do |pipe|
      expected_output = <<EOS
1. Add a scenario
2. List all scenarios
3. Exit
EOS
      pipe.puts "3"
      expected_output << "Peace Out!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
