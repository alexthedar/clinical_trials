require 'spec_helper'

describe(Patient) do
  it { should have_many :visits }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of :name }

  it { should use_before_action :titleize_name }
end
