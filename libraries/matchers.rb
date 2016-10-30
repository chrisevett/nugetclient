if defined?(ChefSpec)
  ChefSpec.define_matcher(:nugetclient_install)

  def install_nugetclient(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:nugetclient_install,
                                            :install,
                                            resource)
  end
end
