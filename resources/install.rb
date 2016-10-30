actions :install
default_action :install

attribute :package_name, kind_of: String, required: true, name_attribute: true
attribute :install_path, kind_of: String, required: true
attribute :package_version, kind_of: String, required: true
attribute :feed_uri, kind_of: String, required: true

attr_accessor :exists
