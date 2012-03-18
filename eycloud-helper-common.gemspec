# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

version = "0.1.0" # TODO get from metadata.json or .rb

Gem::Specification.new do |s|
  s.name        = "eycloud-helper-common"
  s.version     = version
  s.authors     = ["Dr Nic Williams"]
  s.email       = ["drnicwilliams@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Common recipe for EY Cloud} # TODO from metadata
  s.description = %q{Common recipe for EY Cloud} # TODO from metadata long_description

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # s.add_dependency("eycloud-helper-cronjobs")
  s.add_development_dependency("rake")
end
