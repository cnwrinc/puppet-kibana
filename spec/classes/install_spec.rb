require 'spec_helper'

describe 'kibana::install' do

  let(:facts) { { :osfamily => 'RedHat', :operatingsystemrelease => '6.2', :concat_basedir => '/dne' } }

  # DEFAULT PARAMS
  version = '3.1.2'
  site = 'https://github.com/elasticsearch/kibana/archive/'
  target = '/var/www/kibana'
  archtarget = '/opt/' 
  archive = "v#{version}.tar.gz"
  downloadurl = "#{site}/#{archive}"

  context 'with defaults for all parameters' do
    it { should contain_file('/opt/').with_ensure('directory') }

    it { should contain_file('/var/www/kibana').with_ensure('directory') }

    it { should contain_package('curl').with_ensure('present') }

    it { should contain_exec('download-kibana').with('command' => "curl -L -s -S -k -o #{archtarget}/#{archive} #{downloadurl}",
      'path' => '/bin:/usr/bin', 'creates' => "#{archtarget}/#{archive}").that_requires("Package[curl]"
      ).that_requires("File[#{archtarget}]").that_requires("File[#{target}]").that_notifies('Exec[extract-kibana]') }

    it { should contain_exec('extract-kibana').with('command' => "tar --strip-components=1 -zxf #{archtarget}/#{archive} -C #{target}",
      'path' => '/bin:/usr/bin', 'refreshonly' => 'true') }
  end
end
