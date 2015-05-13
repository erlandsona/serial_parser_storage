require_relative '../test_helper'

# In order to have illuminating connections in our quiz results
# I want to add many scenarios

# Usage Example:

#   > ./would_you_rather manage
#   1. Add a scenario
#   2. List all scenarios
#   3. Exit
#   > 1
#   What scenario would you like to add?
#   > butcher a cow
#   "butcher a cow" has been added
#   1. Add a scenario
#   2. List all scenarios
#   3. Exit

# Acceptance Criteria:

#   * Program prints out confirmation that the scenario was added
#   * The scenario is added to the database
#   * After being added, the scenario will be visible via. "List all scenarios", once that feature has been implemented
#   * After the addition, the user is taken back to the main manage menu

class AddingANewScenarioTest < Minitest::Test
end
