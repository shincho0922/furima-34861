class CreateDeliverySources < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_sources do |t|

      t.timestamps
    end
  end
end
