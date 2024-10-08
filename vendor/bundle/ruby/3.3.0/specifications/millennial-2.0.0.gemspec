# -*- encoding: utf-8 -*-
# stub: millennial 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "millennial".freeze
  s.version = "2.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Paul Le".freeze]
  s.date = "2021-05-29"
  s.email = ["hello@paulle.ca".freeze]
  s.homepage = "https://github.com/LeNPaul/Millennial".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.17".freeze
  s.summary = "A minimalist Jekyll theme for running a blog or publication powered by Jekyll and GitHub Pages".freeze

  s.installed_by_version = "3.5.21".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<jekyll>.freeze, ["~> 4.2".freeze])
  s.add_runtime_dependency(%q<jekyll-feed>.freeze, ["~> 0.6".freeze])
  s.add_runtime_dependency(%q<jekyll-paginate>.freeze, ["~> 1.1".freeze])
  s.add_runtime_dependency(%q<jekyll-sitemap>.freeze, ["~> 1.3".freeze])
  s.add_runtime_dependency(%q<jekyll-seo-tag>.freeze, ["~> 2.6".freeze])
end
