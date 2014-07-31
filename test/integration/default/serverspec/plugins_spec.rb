require 'spec_helper'
require 'net/http'
require 'uri'

jenkins_url = 'http://localhost:8080'

describe 'plugins are installed' do

  it 'should no plugin be missing'
    uri = URI.parse(jenkins_url)
    response = Net::HTTP.post_form(uri + '/pluginManager/prevalidateConfig')
    subject do
      { jobs: response.body }
    end
    expect(:jobs).to contain 'job_dsl_seed_jobs'
  end
end


http://localhost:8080/pluginManager/api/json?depth=1&tree=plugins[shortName,version]
