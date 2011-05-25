# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tarte}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Leandro Pedroni"]
  s.date = %q{2010-05-20}
  s.description = %q{Provides a lot of helper methods and uses integer indexes or bitmasks to store in a record an association to a predetermined set of symbols.}
  s.email = %q{ilpoldo@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "init.rb",
     "lib/tarte.rb",
     "lib/tarte/baked_in_associations.rb",
     "lib/tarte/baked_in_validation_helpers.rb",
     "spec/debug.log",
     "spec/schema.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/tarte_spec.rb",
     "tarte.gemspec"
  ]
  s.homepage = %q{http://github.com/ilpoldo/tarte}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Baked in ActiveRecord Associations}
  s.test_files = [
    "spec/schema.rb",
     "spec/spec_helper.rb",
     "spec/tarte_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end
