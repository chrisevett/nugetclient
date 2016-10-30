def whyrun_supported? # ~FC059
  true
end

action :install do
  if @current_resource.exists do
    Chef::Log.info "#{@new_resource} already exists"
  end
  else
    converge_by("Install #{@new_resource}") do
      install_nuget_package
    end
  end
end

# rubocop:disable Metrics/AbcSize
def load_current_resource
  @current_resource = Chef::Resource::NugetclientInstall.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.install_path(@new_resource.install_path)
  @current_resource.package_name(@new_resource.package_name)
  @current_resource.package_version(@new_resource.package_version)
  @current_resource.feed_uri(@new_resource.feed_uri)
  @package_path = "#{new_resource.install_path}" \
                  "#{new_resource.package_name}" \
                  "#{new_resource.package_version}"
  choco_checko
end
# rubocop:enable Metrics/AbcSize

def install_nuget_package
  powershell_script 'deploy package' do
    code <<-EOH
    nuget install #{new_resource.package_name} `
                  -OutputDirectory #{new_resource.install_path} `
                  -Version #{new_resource.package_version} `
                  -Source #{new_resource.feed_uri}
    EOH
    not_if 'Test-Path #{@package_path}'
  end
end

private

def choco_checko
  run_context.include_recipe 'chocolatey'
  chocolatey 'nuget.commandline' do
    action :install
  end

  return unless ::File.directory?(@package_path)
  @current_resource.exists = true
end
