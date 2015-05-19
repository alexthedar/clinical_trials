require 'spec_helper'

describe(Trial) do
  it { should have_many (:visits)}
end
