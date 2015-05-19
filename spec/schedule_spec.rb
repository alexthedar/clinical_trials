require 'spec_helper'

describe(Schedule) do
  it { should have_and_belong_to_many (:visits)}
  it { should belong_to (:trial)}
end
