# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bgw/version'

Gem::Specification.new do |spec|
  spec.name          = "bgw"
  spec.version       = Bgw::VERSION
  spec.authors       = ["Levi Kennedy"]
  spec.email         = ["lckennedy@gmail.com"]
  spec.description   = %q{A better way to manage a git repo via the web}
  spec.summary       = %q{A better way to manage a git repo via the web}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "purdytest"

  spec.add_dependency "sinatra", "~> 1.4.3"
  spec.add_dependency "vegas", "0.1.11"
  spec.add_dependency "rugged", "0.19.0"
end
