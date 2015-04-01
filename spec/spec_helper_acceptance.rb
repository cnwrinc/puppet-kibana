require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    # Install Puppet
    if host.is_pe?
      install_pe
    else
      install_puppet
    end
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  # Fixtures root
  fixture_root = "#{proj_root}/spec/fixtures/modules"
  # Moudle Name
  mod = 'kibana'
  # Readable test descriptions
  c.formatter = :documentation
  
  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => mod)
    hosts.each do |host|
      # scp all module dependencies
      deps = Dir["#{fixture_root}/*"].map { |a| File.basename(a) }
      deps.each do |module_name|
	dep_dir = "#{fixture_root}/#{module_name}"
	scp_to host, dep_dir, "/etc/puppet/modules/#{module_name}", :ignore => ["#{fixture_root}/#{mod}"]
      end
#      Uncomment the following line if manually debugging failures
#      binding.pry

      # Ensures that root password == vagrant so that we can log into the
      # virtual machine to debug failures if BEAKER_destroy=no
      on host, "echo -e 'vagrant\nvagrant' | (passwd --stdin $USER)"
    end
  end
end
