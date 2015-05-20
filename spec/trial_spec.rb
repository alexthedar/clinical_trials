require 'spec_helper'

describe(Trial) do
  it { should have_many (:visits)}
  it { should have_many (:patients)}
  it { should have_many (:specialists)}
  it { should have_many (:schedules)}
  it('should capitalize the first letter') do
    trial = Trial.create({:name => 'acid test', :company => 'boats n hoes'})
    expect(trial.name).to(eq('Acid Test'))
    expect(trial.company).to(eq('Boats N Hoes'))
  end
end
