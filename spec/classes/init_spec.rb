require 'spec_helper'
describe 'kibana' do

  let(:facts) { { :osfamily => 'RedHat', :operatingsystemrelease => '6.2', :concat_basedir => '/dne' } }

  context 'with defaults for all parameters' do
    it { should contain_class('kibana::install') }
    it { should contain_class('kibana::apache') }
  end
end
