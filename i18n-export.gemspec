# -*- encoding: utf-8 -*-
require File.expand_path("lib/i18n_export/version", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name        = "i18n_export"
  s.version     = I18nExport::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["William Howard"]
  s.email       = ["whoward.tke@gmail.com"]
  s.homepage    = %q{http://github.com/cfabianski/i18n_export}
  s.summary     = "Export I18n translations into Javascript file(s)"
  s.description = "It's a small library to provide the I18n translations on the Javascript. Includes Railtie for Rails 3 integration."

  s.files         = Dir.glob("lib/**/*.rb") + Dir.glob("lib/**/*.rake")
  s.test_files    = Dir.glob("test/**/*.rb")
  s.require_paths = ["lib"]

  s.add_dependency "i18n"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
