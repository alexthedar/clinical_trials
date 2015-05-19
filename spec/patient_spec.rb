require 'spec_helper'

describe(Patient) do
  it { should have_many (:visits)}
  it { should have_many (:specialists) }
  it { should have_one (:schedule) }
  it { should have_one (:trial)}

end
