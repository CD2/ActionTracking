# frozen_string_literal: true

require_dependency "#{::ActionTracking::Engine.root}/lib/action_tracking/q/core.rb"

module ActionTracking
  class ActionTrackingRecord < ::ActionTracking::Q::Core
    self.abstract_class = true
  end
end
