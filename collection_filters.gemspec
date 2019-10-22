$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "collection_filters/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "collection_filters"
  spec.version     = CollectionFilters::VERSION
  spec.authors     = ["André Rodrigues"]
  spec.email       = ["andrerpbts@gmail.com"]
  spec.homepage    = "N/A"
  spec.summary     = "A tool to help you to add filter params in your APIs"
  spec.description = "A tool to help you to add filter params in your APIs"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'rails', '>= 5'

  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'shoulda-matchers'
end
