# frozen_string_literal: true

module ActionTrackable
  extend ActiveSupport::Concern

  included do
    has_one :action_tracking_document, as: :actionable,
                                       inverse_of: :actionable,
                                       class_name: '::ActionTracking::Document'

    has_many :actions_as_author, as: :author,
                                 inverse_of: :author,
                                 class_name: '::ActionTracking::Action'

    has_many :actions_as_actionable,       as: :actionable,
                                           inverse_of: :actionable,
                                           class_name: '::ActionTracking::Action'

    after_create :action_tracking_document

    def self.by_action_count(arg = :all)
      if arg.is_a? Hash
        action_type, direction = arg.first.map &:to_s
      else
        action_type = arg.to_s
        direction = 'DESC'
      end

      result = left_joins(:actions_as_actionable)
      unless action_type == 'all'
        result = result.where('action_tracking_actions.action_type = ? OR ' \
          'action_tracking_actions.id IS NULL',
                              ActionTracking::Action.action_types[action_type])
      end
      result.group(:id).order("COUNT(action_tracking_actions.id) #{direction}")
    end
  end

  def action_tracking_document
    super || (new_record? ? nil : create_action_tracking_document!)
  end

  def record_action!(action_type, actionable)
    ::ActionTracking::Action.create_or_count_by(
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
