[![Build status](https://ci.appveyor.com/api/projects/status/hmwh3oismpset4m3/branch/master?svg=true)](https://ci.appveyor.com/project/chrisevett/nugetclient/branch/master)
# nugetclient Cookbook

Provides some nuget cli functionality for chef. I initially wrote this so chef could serve as a drop in replacement for octopus deploy without having to implement a different packaging workflow.  

### Platforms

Supported on windows 2008 and later.

### Chef

Chef 12.0 or later

### Cookbooks
`chocolatey` - nugetclient utilizes the chocolatey cookbook to install the nuget cli tool on the node. 

## Usage

### nugetclient::install

```ruby
include_recipe 'nugetclient'

# Nunit is the package name
nugetclient_install 'Nunit' do
  # escape backslashes in paths
  install_path 'c:\\Nunit'
  package_version '2.6.4'
  feed_uri 'https://www.nuget.org/api/v2/'
end
```

## Contributing
Pull requests welcome.

## License and Authors
MIT
