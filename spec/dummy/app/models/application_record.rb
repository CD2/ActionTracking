# frozen_string_literal: true

require_dependency "#{::ActionTracking::Engine.root}/lib/action_tracking/q/core.rb"

class ApplicationRecord < ::ActionTracking::Q::Core
  self.abstract_class = true
end
