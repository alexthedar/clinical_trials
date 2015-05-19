require 'spec_helper'

describe(Specialist) do
  it { should have_many (:visits)}
  it { should have_many (:vacations)}
  it { should have_many (:patients)}
  it { should have_many (:trials)}

end
