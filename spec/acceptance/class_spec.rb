require 'spec_helper_acceptance'

describe 'nginx class' do

  context 'minimal parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'nginx': 
        site_git_src    => "https://github.com/puppetlabs/exercise-webpage.git",
      }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe 'nginx should be serving puppetlabs site' do
      it 'should contain puppetlabs text' do
        shell("wget http://127.0.0.1:8000/ -O - | grep 'puppetlabs'", :acceptable_exit_codes => 0)
      end
    end
    describe '.git clone should be cleaned up' do
      # Ensure .git files were removed for security
      it 'should not contain .git folders' do
        shell("find /usr/share/nginx/exercise/ -name '*.git'| grep '.git'", :acceptable_exit_codes => 1)
      end
    end
  end

  context 'Custom parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'nginx':
        listenport      => 9000,
        package_name    => "nginx",
        service_name    => "nginx",
        service_ensure  => "running",
        site_git_src    => "https://github.com/puppetlabs/exercise-webpage.git",
        site_folder_dst => "/usr/share/nginx/exercise/",
      }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe 'nginx should be serving puppetlabs site' do
      it 'should contain puppetlabs text' do
        shell("wget http://127.0.0.1:9000/ -O - | grep 'puppetlabs'", :acceptable_exit_codes => 0)
      end
    end
  end
end
