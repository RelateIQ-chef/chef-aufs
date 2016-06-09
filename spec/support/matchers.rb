def load_modules(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:modules, :load, resource_name)
end
