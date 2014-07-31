require 'spec_helper'

describe user('jenkins') do
  it { should exist }
  it { should belong_to_group 'jenkins' }
  it { should have_home_directory '/home/jenkins' }
end

describe group('jenkins') do
  it { should exist }
end

describe file('/home/jenkins/.ssh/jenkins-ci-insecure') do
  it { should exist }
  it { should be_mode '0600' }
  it { should be_owned_by 'jenkins' }
end
