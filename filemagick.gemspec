# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filemagick/version'

Gem::Specification.new do |spec|
  spec.name          = "filemagick"
  spec.version       = Filemagick::VERSION
  spec.authors       = ["Kashyap"]
  spec.email         = ["kashyap.kmbc@gmail.com"]
  spec.summary       = %q{ Pure Ruby file validator based on magic number checking }
  spec.description   = %q{ Pure Ruby file validator based on magic number checking }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0") + [ 'Rakefile', 'README.md', 'LICENSE.txt' ]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
