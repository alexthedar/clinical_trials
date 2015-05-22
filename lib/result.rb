class Result
  attr_reader(:conflict, :warning, :scheduled_visit)

  def initialize(results)
    @conflicts = Conflict.new(attributes[:conflicts]).parse
    @warnings = Warning.new(attributes[:warnings]).parse
    @scheduled_visits = Struct.new(attributes[:scheduled_visits]).parse
    # @results = parse(results)
  end

  Conflict = Struct.new(:visit_conflict, :conflict_reason, :date) do
    def initialize
      @visit_conflict = attributes[:visit_conflict]
    end
  end

  Warning = Struct.new(:visit_conflict, :warning_reason, :date)




  Scheduled_Visit = Struct.new(:visit)

  def parse(messages)
    messages.collect do |cell|
binding.pry
      Conflict.new(cell[0], cell[1], cell[2])
      Warning.new(cell[0], cell[1], cell[2])
      Scheduled_Visit.new(cell[0])
    end
  end
end
