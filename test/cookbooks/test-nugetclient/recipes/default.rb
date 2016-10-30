#
# Cookbook Name:: test-nugetclient
# Recipe:: default
#
# MIT license

include_recipe 'nugetclient'

nugetclient_install 'Nunit' do
  install_path 'c:\\Nunit'
  package_version '2.6.4'
  feed_uri 'https://www.nuget.org/api/v2/'
end
