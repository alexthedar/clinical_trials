require 'spec_helper'

describe(Patient) do
  it { should have_many (:visits)}
  it { should have_many (:specialists) }

end
