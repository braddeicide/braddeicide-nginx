source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :test do
  gem 'beaker-rspec', :require => false
  gem 'puppet-lint',  :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

