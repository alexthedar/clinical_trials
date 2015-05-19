require 'spec_helper'

describe(Visit) do
  it { should belong_to (:patient)}
  it { should belong_to (:schedule)}
  it { should belong_to (:specialist)}
  it { should belong_to (:trial)}

end
