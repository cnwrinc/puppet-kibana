require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
#require 'hiera-puppet-helper/rspec'
require 'hiera'
require 'puppet/indirector/hiera'
require 'hiera-puppet-helper'

#hiera helper
def hiera_stub
  config = Hiera::Config.load(hiera_config)
  config[:logger] = 'puppet'
  Hiera.new(:config => config)
end
 
RSpec.configure do |config|
  config.mock_framework = :rspec
	    
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  #hiera helper
  config.before(:each) do
    Puppet::Indirector::Hiera.stub(:hiera => hiera_stub)
  end
    
end

shared_context "hieradata" do
  let(:hiera_config) do
    { :backends => ['rspec', 'yaml'],
      :hierarchy => [
        'pageplus_users_data'],
      :yaml => {
        :datadir => File.expand_path(File.join(__FILE__, '..', '..', 'spec/fixtures/hiera')) },
      :rspec => respond_to?(:hiera_data) ? hiera_data : {} }
  end
end
