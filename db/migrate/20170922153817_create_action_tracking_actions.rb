class CreateActionTrackingActions < ActiveRecord::Migration[5.1]
  def change
    create_table :action_tracking_actions do |t|
      t.references :author, polymorphic: true, null: false
      t.references :actionable, polymorphic: true, null: false, index: false
      t.integer :action_type, null: false
      t.integer :counter, default: 1

      t.timestamps
    end

    add_index :action_tracking_actions, %i[actionable_id actionable_type], name: :index_actions_on_actionable
    add_index :action_tracking_actions, %i[author_id author_type actionable_id actionable_type], name: :index_actions_on_author_and_actionable
  end
end
