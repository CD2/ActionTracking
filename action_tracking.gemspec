# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'action_tracking/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'action_tracking'
  s.version     = ActionTracking::VERSION
  s.authors     = ['James Page']
  s.email       = ['james.page@cd2solutions.co.uk']
  s.homepage    = 'https://cd2solutions.co.uk/'
  s.summary     = 'Summary of ActionTracking.'
  s.description = 'Description of ActionTracking.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1.3'

  s.add_dependency 'pg'
  # s.add_dependency 'cord'
end
