require 'spec_helper'

describe(Visit) do
  it { should belong_to (:patient)}
  it { should have_and_belong_to_many (:schedules)}
  it { should belong_to (:specialist)}
  it { should belong_to (:trial)}

end
