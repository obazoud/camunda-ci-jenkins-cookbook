require 'spec_helper'

describe 'camunda-ci-jenkins::plugins' do
  let(:chef_run) do
    ChefSpec::Runner.new(
      platform: 'ubuntu',
      version: '14.04'
    )
  end

  context 'when plugins are specified' do
    it 'should include plugins recipes' do
      chef_run.converge(described_recipe)

      expect(chef_run).to include_recipe('camunda-ci-jenkins::plugins')
    end
  end

end

