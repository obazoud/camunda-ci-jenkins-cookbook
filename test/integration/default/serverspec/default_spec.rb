require 'spec_helper'

describe package('jenkins') do
  it { should be_installed }
end

describe service('jenkins') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening.on('127.0.0.1').with('tcp') }
end
