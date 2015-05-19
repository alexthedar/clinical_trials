require 'spec_helper'

describe(Specialist) do
  it { should have_many (:visits)}
end
