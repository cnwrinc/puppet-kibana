require 'spec_helper'

describe 'kibana::apache' do

  let(:facts) { { :osfamily => 'RedHat', :operatingsystemrelease => '6.2', :concat_basedir => '/dne' } }

  context 'with defaults for all parameters' do
    it { should contain_class('apache').with('default_vhost' => 'false') }

    it { should contain_apache__vhost('kibana').with('docroot' => '/var/www/kibana/src/',
      'port' => '80').that_requires('Class[kibana::install]') }
  end
end
