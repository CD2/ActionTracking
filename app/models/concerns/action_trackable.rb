# frozen_string_literal: true

module ActionTrackable
  extend ActiveSupport::Concern

  included do
    has_one :action_tracking_document, {
      as: :actionable,
      inverse_of: :actionable,
      class_name: '::ActionTracking::Document'
    }

    has_many :actions_as_author, {
      as: :author,
      inverse_of: :author,
      class_name: '::ActionTracking::Action'
    }

    has_many :actions_as_actionable, {
      as: :actionable,
      inverse_of: :actionable,
      class_name: '::ActionTracking::Action'
    }

    after_create :action_tracking_document
  end

  def action_tracking_document
    super || (new_record? ? nil : create_action_tracking_document!)
  end

  def record_action! action_type, actionable
    ::ActionTracking::Action.create_or_count(
      author: self, action_type: action_type, actionable: actionable
    )
  end

  def action_counts
    return {}.with_indifferent_access unless action_tracking_document
    action_tracking_document.counters.with_indifferent_access
  end

  def recalculate_action_counts!
    result = {}
    ::ActionTracking::Action.action_types.each do |action_type, _|
      result[action_type] = ::ActionTracking::Action.where(
        actionable: self,
        action_type: action_type
      ).sum(:counter)
    end
    action_tracking_document.update!(counters: result)
  end
end
