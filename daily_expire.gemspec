Gem::Specification.new do |s|
  s.name        = "daily_expire"
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Gregory Marcilhacy"]
  s.email       = ["g.marcilhacy@gmail.com"]
  s.homepage    = "https://github.com/gregorym/daily_expire"
  s.summary     = %q{Expire your cache every day or any day of the week }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency 'chronic', '>= 0.6.7'

  s.add_development_dependency 'rspec', '~> 2.6'
end