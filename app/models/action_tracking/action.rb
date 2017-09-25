# frozen_string_literal: true

module ActionTracking
  class Action < ::ActionTracking::ActionTrackingRecord
    belongs_to :author, polymorphic: true, inverse_of: :actions_as_author
    belongs_to :actionable, polymorphic: true, inverse_of: :actions_as_actionable

    validates :action_type, :counter, presence: true

    config_types = ActionTracking.custom_action_types
    enum action_type: %i[creates reads updates destroys] + config_types

    after_create :increment_counter

    def self.create_or_count attrs
      if record = find_by(attrs)
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
      doc.counters[action_type] ||= 0
      doc.counters[action_type] += 1
      doc.save!
    end
  end
end
