require 'spec_helper_acceptance'

describe 'kibana::apache' do
  describe 'using default' do
    it 'should work with no errors' do
      pp ="class { 'kibana::apache': }"
      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/httpd/conf.d/25-kibana.conf') do
      it { should be_file }
    end
  end
end
