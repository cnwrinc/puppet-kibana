require 'spec_helper_acceptance'

describe 'kibana::install' do
  describe 'using default' do
    it 'should work with no errors' do
      pp ="class { 'kibana::install': }"
      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/opt') do
      it { should be_directory }
    end

    describe file('/var/www/kibana') do
      it { should be_directory }
    end

    describe package('curl') do
      it { should be_installed }
    end

    describe file('/opt/v3.1.2.tar.gz') do
      it { should be_file }
    end
  end
end
