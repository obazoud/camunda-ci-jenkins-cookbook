require 'spec_helper'

describe service('jenkins') do
  it { should be_enabled }
  it { should be_running }
end
