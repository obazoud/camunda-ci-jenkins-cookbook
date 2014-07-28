require 'spec_helper'

describe 'camunda-ci-jenkins::config' do
  let(:chef_run) do
    ChefSpec::Runner.new(
      platform: 'ubuntu',
      version: '14.04'
    )
  end

  context 'when config template is rendered' do
    it 'should include the basic properties' do
      chef_run.node.set['camunda']['jenkins']['home'] = '/var/lib/jenkins'
      chef_run.converge(described_recipe)

      expect(chef_run).to include_recipe('camunda-ci-jenkins::config')
      expect(chef_run).to create_template('config.xml')
        .with_path('/var/lib/jenkins/config.xml')
      expect(chef_run).to render_file('/var/lib/jenkins/config.xml')
        # .with_content(/.*<disableRememberMe>false<\/disableRememberMe>.*/)
    end
  end

end
