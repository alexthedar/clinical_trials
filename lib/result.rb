class Results
  attr_reader(:conflicts, :warnings, :scheduled_visits)

  def initialize(attributes)
    @conflicts = attributes[:conflicts]
    @warnings = attributes[:warnings]
    @scheduled_visits = attributes[:scheduled_visits]
  end


end
