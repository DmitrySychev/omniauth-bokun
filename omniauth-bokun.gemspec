
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omniauth/bokun/version"

Gem::Specification.new do |spec|
  spec.name          = "omniauth-bokun"
  spec.version       = Omniauth::Bokun::VERSION
  spec.authors       = ["Dmitry Sychev"]
  spec.email         = ["dmitry.sychev@me.com"]

  spec.summary       = %q{unofficial omniauth strategy for Bokun}
  spec.description   = "An unofficial OmniAuth strategy for Bokun, allowing authentication via Bokun's OAuth2 API."
  spec.homepage      = "https://github.com/DmitrySychev/omniauth-bokun"
  spec.metadata    = {
      "source_code_uri" => "https://github.com/DmitrySychev/omniauth-bokun",
    }
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.files = Dir['lib/**/*.rb']

  spec.add_dependency 'omniauth', '~> 2.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.8'
  spec.add_development_dependency "bundler", "~> 2.5"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "debug", "~> 1.0" if RUBY_VERSION >= "3.1"
end
