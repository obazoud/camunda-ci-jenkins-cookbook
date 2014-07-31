require 'spec_helper'
require 'net/http'
require 'uri'

jenkins_url = 'http://localhost:8080'

describe 'jenkins seed job is present' do
  uri = URI.parse(jenkins_url)

  response = Net::HTTP.get_response(uri + '/api/json?tree=jobs[name]')
  subject do
    { jobs: response.body }
  end
  expect(:jobs).to contain 'job_dsl_seed_jobs'
end
