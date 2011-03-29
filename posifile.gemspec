Gem::Specification.new do |s|
	s.name = 'posifile'
	s.version = '0.1.0'
	s.summary = 'Inteds to make easier to read position files.'
	s.description = 'Inteds to make easier to read position files. Still very imature.'
	s.files = `git ls-files`.split("\n")
	s.homepage = 'http://github.com/marcofognog/posifile'
  s.platform = Gem::Platform::RUBY
	s.authors = ["Marco Antonio Fogaça Nogueira"]
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.7")
  s.email = ["marcofognog@gmail.com"]
  s.require_paths = ["lib"]
end
