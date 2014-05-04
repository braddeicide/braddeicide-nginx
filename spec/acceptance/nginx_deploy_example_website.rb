describe 'nginx class' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'nginx': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    # Big stick, makes most other tests redundant.  Note, relies on port 8000.
    # `cat /etc/nginx/sites-enabled/exercise_webpage | grep listen | awk '{print $2}'`
    describe 'should contain puppetlabs content' do
      it 'should delete accounts' do
        shell("wget http://127.0.0.1:8000/ -O - | grep 'puppetlabs'", :acceptable_exit_codes => 0)
      end

    # Ensure .git files were removed for security
      it 'should not contain .git folders' do
        shell("find /usr/share/nginx/exercise/ -name '*.git'| wc -l", :acceptable_exit_codes => 1)
      end
    end
  end
end
