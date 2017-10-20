# frozen_string_literal: true

require 'action_tracking/engine'

module ActionTracking
  class << self
    mattr_accessor :custom_action_types
    self.custom_action_types = []

    def setup
      yield self
    end
  end
end
