require_relative '../test_helper'

describe Reading do

  describe "#find" do

    describe "if there are no results" do

      it "should return an empty array" do
        assert_equal [], Reading.find
      end

    end

    describe "if there are results" do

      before :all do
        record_test_readings
      end

      it "should return the correct number of rows for no arguments given" do
        readings = Reading.find.map {|reading| reading.pressure_value}
        assert_equal 20, readings.length
      end

      it "should return the correct number of rows for id" do
        readings = Reading.find(id: 1)
        assert_equal 10, readings.length
      end

      it "should return the correct number of rows for sensor_id" do
        readings = Reading.find(sensor_id: 1).map {|reading| reading.sensor_id}
        assert_equal [1], readings
      end

      it "should return the correct number of rows for pressure_value" do
        readings = Reading.find(pressure_value: 1)
        assert_equal 17, readings.length
      end

      it "should return the correct number of rows for id AND sensor_id" do
        readings = Reading.find(id: 1, sensor_id: 2)
        assert_equal 1, readings.length
      end

      it "should return the correct number of rows for id AND pressure_value" do
        readings = Reading.find(id: 1, pressure_value: 1)
        assert_equal 8, readings.length
      end

      it "should return the correct number of rows for sensor_id AND pressure_value" do
        readings = Reading.find(sensor_id: 3, pressure_value: 1)
        assert_equal 2, readings.length
      end

      it "should return the correct number of rows for all args" do
        readings = Reading.find(id: 1, sensor_id:3, pressure_value: 1)
        assert_equal 1, readings.length
      end

    end

  end

  describe "#record" do

    it "should return true" do
      actual = Reading.record(time: 0.1)
      actual = true if actual.is_a?(String)
      assert_equal true, actual
    end

  end


end
