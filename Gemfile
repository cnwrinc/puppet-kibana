source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.7.0'
  gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem "puppetlabs_spec_helper"
  gem "metadata-json-lint"
  gem 'hiera-puppet-helper',     :git => 'git://github.com/bobtfish/hiera-puppet-helper.git'
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "vagrant-wrapper"
  gem "puppet-blacksmith"
  gem "guard-rake"
end

group :system_tests do
  gem "beaker", :git => 'git@github.com:puppetlabs/beaker.git', :ref => 'f3b9035'
  gem "beaker-rspec"
  gem "serverspec"
end
