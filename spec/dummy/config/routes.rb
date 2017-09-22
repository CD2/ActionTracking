# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionTracking::Engine => "/action_tracking"
  root 'application#root'
end
