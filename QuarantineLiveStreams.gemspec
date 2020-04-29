require_relative 'lib/QuarantineLiveStreams/version'

Gem::Specification.new do |spec|
  spec.name          = "QuarantineLiveStreams"
  spec.version       = QuarantineLiveStreams::VERSION
  spec.authors       = ["mattenbar"]
  spec.email         = ["matthew.enbar@gmail.com"]

  spec.summary       = %q{CLI scraper for quarantine live streams}
  spec.description   = %q{Scrapes upcoming events that are being live streamed and then returns the date time and link ot the event}
  spec.homepage      = "https://github.com/mattenbar/QLS"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mattenbar/QLS"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["QLS"] 
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
  spec.add_dependency "uri"
  spec.add_dependency "colorize", '~> 0.8.1'

end

