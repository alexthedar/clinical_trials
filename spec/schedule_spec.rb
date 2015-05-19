require 'spec_helper'

describe(Schedule) do
  it { should have_many (:visits)}
  it { should belong_to (:trial)}
  it { should have_many (:patients) }

end
