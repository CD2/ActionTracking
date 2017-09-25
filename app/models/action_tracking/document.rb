# frozen_string_literal: true

module ActionTracking
  class Document < ::ActionTracking::ActionTrackingRecord
    belongs_to :actionable, polymorphic: true, inverse_of: :action_tracking_document

    def counters
      Hash.new { 0 }.merge super
    end
  end
end
