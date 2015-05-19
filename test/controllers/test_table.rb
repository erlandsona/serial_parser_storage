require_relative '../test_helper'

describe Table do

  describe "#generate" do

    describe "if there are no scenarios in the database" do

      it "should return an empty table" do
        output = Table.new.generate
        expected = <<-TABLE
┏━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃    Session #    ┃    Sensor ID    ┃ Pressure Value ┃              Time Stamp              ┃
┗━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
        TABLE
        assert_equal expected, output
      end

    end

  end

end
