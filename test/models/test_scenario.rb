require_relative '../test_helper'

describe Scenario do
  describe "#all" do
    describe "if there are no scenarios in the database" do
      it "should return an empty array" do
        assert_equal [], Scenario.all
      end
    end
    describe "if there are scenarios" do
      before do
        create_scenario("Bob")
        create_scenario("Sally")
        create_scenario("Amanda")
      end
      it "should return an array" do
        # You don't need to be pedantic like this.
        # This is just an example to remind you that you can use multiple "its"
        assert_equal Array, Scenario.all.class
      end
      it "should return the scenarios in alphabetical order" do
        expected = ["Amanda", "Bob", "Sally"]
        actual = Scenario.all.map{ |scenario| scenario.name }
        assert_equal expected, actual
      end
    end
  end

  describe "#count" do
    describe "if there are no scenarios in the database" do
      it "should return 0" do
        assert_equal 0, Scenario.count
      end
    end
    describe "if there are scenarios" do
      before do
        create_scenario("Bob")
        create_scenario("Sally")
        create_scenario("Amanda")
      end
      it "should return the correct count" do
        assert_equal 3, Scenario.count
      end
    end
  end
end
