if defined?(ChefSpec)
  ChefSpec.define_matcher :yum_package
  ChefSpec.define_matcher :remote_file

  def install_yum_package(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:yum_package, :install, resource_name)
  end

  def create_remote_file(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:remote_file, :create, resource_name)
  end
end
