class WiggleColumnForTrials < ActiveRecord::Migration
  def change
    add_column(:trials, :wiggle, :int)
  end
end
