# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "decidim/homes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.version = Decidim::Homes.version
  s.authors = ["Giovanni Alvissus Camargo Giampauli"]
  s.email = ["giovanni.acg@gmail.com"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-homes"
  s.required_ruby_version = ">= 3.0"

  s.name = "decidim-homes"
  s.summary = "Decidim homes module"
  s.description = "A homes component for decidim's participatory processes."

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::Homes.version

  s.add_development_dependency "decidim-dev", Decidim::Homes.version
  s.add_development_dependency "decidim-participatory_processes", Decidim::Homes.version
end
