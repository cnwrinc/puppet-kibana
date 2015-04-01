require 'spec_helper_acceptance'

describe 'kibana' do
  describe 'using default' do
    it 'should work with no errors' do
      pp ="class { 'kibana': }"
      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end
