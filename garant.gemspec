require_relative 'lib/garant/version'

Gem::Specification.new do |spec|
  spec.name          = "garant"
  spec.version       = Garant::VERSION
  spec.authors       = ["Sergey Fedorov"]
  spec.email         = ["creadone@gmail.com"]
  spec.summary       = %q{Helper for generation unique hashes.}
  spec.description   = %q{Garant prevents the collisions when generating a large number of hashes.}
  spec.homepage      = "http://github.com/creadone/garant"
  spec.license       = "MIT"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.add_runtime_dependency     'bloomer',  '~> 1.0'
  spec.add_development_dependency 'rake',     '~> 12.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]
end
