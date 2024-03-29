# frozen_string_literal: true

module ActionTracking
  class Action < ::ActionTracking::ActionTrackingRecord
    belongs_to :author, polymorphic: true
    belongs_to :actionable, polymorphic: true

    validates :action_type, :counter, presence: true

    config_types = ActionTracking.custom_action_types
    enum action_type: %i[creates reads updates destroys] + config_types

    after_save :increment_counter

    def self.create_or_count_by(attrs)
      find_attrs = attrs.with_indifferent_access.slice(
        :author, :author_id, :author_type, :actionable, :actionable_id,
        :actionable_type, :action_type
      )
      if record = find_by(find_attrs)
        record.update(counter: record.counter + 1)
      else
        create(attrs)
      end
    end

    private

    def increment_counter
      doc = ::ActionTracking::Document.find_or_initialize_by(
        actionable: actionable
      )
      value = if saved_change_to_id?
                counter
              else
                counter - counter_before_last_save
      end
      doc.counters = doc.counters.merge(
        action_type => doc.counters[action_type] + value
      )
      doc.save!
    end
  end
end
