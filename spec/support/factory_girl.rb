# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    FactoryGirl.find_definitions
  end
end
