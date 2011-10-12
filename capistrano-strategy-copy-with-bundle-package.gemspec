# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'capistrano-strategy-copy-with-bundle-package/version'

Gem::Specification.new do |s|
  s.name        = 'capistrano-strategy-copy-with-bundle-package'
  s.version     = CapistranoStrategyCopyWithBundlePackage::VERSION
  s.authors     = ['Rainux Luo']
  s.email       = ['rainux@gmail.com']
  s.homepage    = 'https://github.com/rainux/capistrano-strategy-copy-with-bundle-package'
  s.summary     = %q{Deploy your Ruby application to a server which can't access rubygems.org over Internet.}
  s.description = <<-DESC
    CopyWithBundlePackage is a capistrano strategy similar to copy strategy,
    but with gems packaged by bundler.

    It will package all gems in the copy directory and then upload to servers,
    so the server no longer required to access rubygems.org.
  DESC

  s.rubyforge_project = 'capistrano-strategy-copy-with-bundle-package'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'capistrano', '~> 2'
end
