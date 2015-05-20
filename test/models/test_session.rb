require_relative '../test_helper'

describe Session do

  describe "#find" do

    describe "if there are no results" do

      it "should return an empty array" do
        assert_equal [], Session.find
      end

    end

    describe "if there are results" do

      before(:all) do
        record_test_sessions
      end

      it "should return the correct number of rows for no arguments given" do
        session = Session.find
        assert_equal 20, session.length
      end

      it "should return the correct number of rows for id" do
        session = Session.find(id: 1)
        assert_equal 10, session.length
      end

      it "should return the correct number of rows for sensor_id" do
        session = Session.find(sensor_id: 1)
        assert_equal 1, session.length
      end

      it "should return the correct number of rows for pressure_value" do
        session = Session.find(pressure_value: 1)
        assert_equal 17, session.length
      end

      it "should return the correct number of rows for id AND sensor_id" do
        session = Session.find(id: 1, sensor_id: 2)
        assert_equal 1, session.length
      end

      it "should return the correct number of rows for id AND pressure_value" do
        session = Session.find(id: 1, pressure_value: 1)
        assert_equal 8, session.length
      end

      it "should return the correct number of rows for sensor_id AND pressure_value" do
        session = Session.find(sensor_id: 3, pressure_value: 1)
        assert_equal 2, session.length
      end

      it "should return the correct number of rows for all args" do
        session = Session.find(id: 1, sensor_id:3, pressure_value: 1)
        assert_equal 1, session.length
      end

    end

  end




end
