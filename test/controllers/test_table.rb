require_relative '../test_helper'

describe Table do

  describe "#generate" do

    describe "if there are no scenarios" do

      it "should return an empty table" do
        output = Table.new.generate
        expected = <<-TABLE
┏━━━━━━━━━━━┳━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ \e[1m\e[35mSession #\e[0m\e[0m ┃ \e[1m\e[35mSensor ID\e[0m\e[0m ┃ \e[1m\e[35mPressure Value\e[0m\e[0m ┃ \e[1m\e[35m        Time Stamp       \e[0m\e[0m ┃
┗━━━━━━━━━━━┻━━━━━━━━━━━┻━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
        TABLE
        assert_equal expected, output
      end

    end

  end

end
