class CreateFindingMetricJoinTable < ActiveRecord::Migration
  def self.up
    create_table :findings_metrics, :id => false do |t|
	  t.integer :finding_id
	  t.integer :metric_id
	end
  end

  def self.down
    drop_table :findings_metrics
  end
end
