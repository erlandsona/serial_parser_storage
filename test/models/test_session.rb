require_relative '../test_helper'

describe Session do

  describe "#all" do

    describe "if there are no sessions in the database" do

      it "should return an empty array" do
        assert_equal [], Session.all
      end

    end

    describe "if there are sessions" do

      before do
        record_test_sessions
      end

      it "should return the sessions" do
        expected = ["Amanda", "Bob", "Sally"]
        actual = Session.all
        assert_equal expected, actual
      end

    end

  end




end
