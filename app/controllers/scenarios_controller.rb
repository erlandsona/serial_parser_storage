class ScenariosController
  def index
    if Scenario.count > 0
      scenarios = Scenario.all # All of the scenarios in an array
      scenarios.each_with_index do |scenario, index|
        say("#{index + 1}. #{scenario.name}") #=> 1. Eat a pencil
      end
    else
      say("No scenarios found. Add a scenario.\n")
    end
  end
end
