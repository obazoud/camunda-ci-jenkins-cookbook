require 'chefspec'
require 'chefspec/server'     # automatically starts a chef-zero server
require 'chefspec/berkshelf'  # enable berkshelf integration

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
