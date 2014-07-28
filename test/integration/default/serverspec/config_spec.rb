require 'spec_helper'

# chef
describe file('/etc/httpd/conf/httpd.conf') do
  its(:content) { should match /ServerName www.example.jp/ }
end

describe file('/etc/httpd/conf/httpd.conf') do
  it { should contain 'ServerName www.example.jp' }
end