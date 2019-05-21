
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "protect_connect/version"

Gem::Specification.new do |spec|
  spec.name          = "protect_connect"
  spec.version       = ProtectConnect::VERSION
  spec.authors       = ["Rich Davis"]
  spec.email         = ["vgcrld@gmail.com"]

  spec.summary       = %q{Spectrum Protect Connect to Server Gem}
  spec.description   = %q{Pull data from a TSM Server / Spectrum Protect}
  spec.homepage      = "http://galileosuite.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
