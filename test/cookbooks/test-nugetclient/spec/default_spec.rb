require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'windows'
  config.version = '2012R2'
end

nugetinstall = <<-EOH
    nuget install Nunit `
                  -OutputDirectory c:\\Nuget\\ `
                  -Version 2.6.3 `
                  -Source https://www.nuget.org/api/v2/
EOH

describe 'test-nugetclient::default' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(step_into: ['nugetclient_install'])
    runner.node.set['nugetclient']['install_path'] = 'c:\\nuget\\'
    runner.node.set['nugetclient']['package_version'] = '2.6.3'
    runner.node.set['nugetclient']['package_name'] = 'Nunit'
    runner.converge(described_recipe)
  end

  describe 'when a package doesnt exist' do
    before(:each) do
      stub_command("Test-Path \#{package_path}").and_return(false)
    end
    it 'should install the package if it doesnt exist' do
      expect(chef_run).to run_powershell_script('deploy package')
    end
  end

  describe 'when a package does exist' do
    before(:each) do
      stub_command("Test-Path \#{package_path}").and_return(true)
    end
    it 'should not install the package if it does exist' do
      expect(chef_run).to_not run_powershell_script(nugetinstall)
    end
  end
end
