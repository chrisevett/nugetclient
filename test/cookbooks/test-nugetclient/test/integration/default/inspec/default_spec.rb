# functional tests for nugetclient-test cookbook

# look for our folder
describe directory('C:\\Nunit\\NUnit.2.6.4') do
  it { should be_directory }
end

# look for a file we expect to see inside
describe file('c:\\Nunit\\Nunit.2.6.4\\NUnit.2.6.4.nupkg') do
  it { should exist }
  it { should be_file }
end
