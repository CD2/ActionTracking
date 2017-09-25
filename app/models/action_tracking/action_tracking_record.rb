# frozen_string_literal: true

require_dependency "#{::ActionTracking::Engine.root}/lib/q/core.rb"

module ActionTracking
  class ActionTrackingRecord < Q::Core
    self.abstract_class = true
  end
end
