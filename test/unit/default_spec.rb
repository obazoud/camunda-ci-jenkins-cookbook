require 'spec_helper'

describe 'camunda-ci-jenkins::default' do
  let(:chef_run) do
    ChefSpec::Runner.new(
      platform: 'ubuntu',
      version: '14.04'
    )
  end

  context 'when usage is default and no plugins are specified' do
    it 'should include only the default and config recipes' do
      chef_run.node.set['camunda']['jenkins']['security'] = 'ldap'
      chef_run.node.set['camunda']['jenkins']['plugins'] = []
      chef_run.converge(described_recipe)

      expect(chef_run).to include_recipe('camunda-ci-jenkins::default')
      expect(chef_run).to include_recipe('camunda-ci-jenkins::config')
      expect(chef_run).not_to include_recipe('camunda-ci-jenkins::credentials')
      expect(chef_run).not_to include_recipe('camunda-ci-jenkins::plugins')
    end
  end

  context 'when security mechanism is password' do
    it 'should include credentials recipes' do
      chef_run.node.set['camunda']['jenkins']['security'] = 'password'
      chef_run.converge(described_recipe)

      expect(chef_run).to include_recipe('camunda-ci-jenkins::credentials')
    end
  end

  context 'when plugins are specified' do
    it 'should include plugins recipes' do
      chef_run.node.set['camunda']['jenkins']['plugins'] = [{ name: 'docker-plugin', version: '0.6.2' }]
      chef_run.converge(described_recipe)

      expect(chef_run).to include_recipe('camunda-ci-jenkins::plugins')
    end
  end

end
