require 'spec_helper'

describe 'camunda-ci-jenkins::credentials' do
  let(:chef_run) do
    ChefSpec::Runner.new(
      platform: 'ubuntu',
      version: '14.04'
    )
  end

  it 'should include camunda-ci-jenkins::credentials recipe' do
    chef_run.converge(described_recipe)

    expect(chef_run).to include_recipe('camunda-ci-jenkins::credentials')
  end

end
