class CreateActionTrackingDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :action_tracking_documents do |t|
      t.references :actionable, polymorphic: true, index: false, null: false
      t.jsonb :counters, default: {}, null: false

      t.timestamps
    end

    add_index :action_tracking_documents, %i[actionable_id actionable_type], unique: true, name: :index_action_tracking_documents_on_actionable
    add_index :action_tracking_documents, :counters, using: :gin
  end
end
