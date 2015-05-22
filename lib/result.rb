class Results
  attr_reader(:conflicts, :warnings, :scheduled_visits)

  def initialize(results)
    # @conflicts = attributes[:conflicts]
    # @warnings = attributes[:warnings]
    # @scheduled_visits = attributes[:scheduled_visits]
    @results = parse(results)
  end

  Conflict = Struct.new(:visit_conflict, :conflict_reason, :date)
  Warning = Struct.new(:visit_conflict, :warning_reason, :date)
  Scheduled_Visit = Struct.new(:visit)

  def parse(results)
    results.collect do |cell|
binding.pry      
      Conflict.new(cell[0], cell[1], cell[2])
      Warning.new(cell[0], cell[1], cell[2])
      Scheduled_Visit.new(cell[0])
    end
  end
end
