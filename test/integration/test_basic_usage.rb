require_relative '../test_helper'

class TestBasicUsage < Minitest::Test

  def test_program_starts_with_options
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage', 'r+') do |pipe|
      expected_output = main_menu
      pipe.puts "3"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_program_ignores_string_arguments
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage blah', 'r+') do |pipe|
      expected_output = error
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_program_ignores_multiple_arguments
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage blah 1234lkjadsf!@#$', 'r+') do |pipe|
      expected_output = error
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_program_ignores_number_arguments
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage 123', 'r+') do |pipe|
      expected_output = error
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_program_ignores_symbols_as_arguments
    shell_output = ""
    expected_output = ""
    IO.popen('./serial_parser_storage {}!@#$#^', 'r+') do |pipe|
      expected_output = error
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end




end
