source 'https://rubygems.org'

gem 'berkshelf'

# Uncomment these lines if you want to live on the Edge:
#
# group :development do
#   gem "berkshelf", github: "berkshelf/berkshelf"
#   gem "vagrant", github: "mitchellh/vagrant", tag: "v1.6.3"
# end
#

group :plugins do
  gem "vagrant-berkshelf", github: "berkshelf/vagrant-berkshelf"
  gem "vagrant-omnibus", github: "schisamo/vagrant-omnibus"
  gem "vagrant-cachier", github: "fgrehm/vagrant-cachier"
  #gem "vagrant-chef-zero", github: "andrewgross/vagrant-chef-zero"
end

group :testing do
  # test frameworks
  gem 'foodcritic'
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'chefspec'
  gem 'serverspec', '>= 2.0.0.beta8'
  gem 'rubocop'

  # continuous testing during development
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-kitchen'
  gem 'guard-foodcritic'
  gem 'guard-rubocop'
end

gem 'chef-zero'
gem 'chef-vault'

# group :production do
#   gem 'knife-solo'
#   gem 'knife-solo_data_bag'
# end