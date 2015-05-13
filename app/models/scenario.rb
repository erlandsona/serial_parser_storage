class Scenario
  attr_accessor :name

  def self.all
    Database.execute("select name from scenarios order by name ASC").map do |row|
      scenario = Scenario.new
      scenario.name = row[0]
      scenario
    end
  end

  def self.count
    Database.execute("select count(id) from scenarios")[0][0]
  end
end
