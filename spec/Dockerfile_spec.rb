require "serverspec"
require "docker"

describe "Docker Image" do
  before(:all) do
    if !ENV['IMAGE_ID'].nil? && !ENV['IMAGE_ID'].empty?
      @image = Docker::Image.get("#{ENV['IMAGE_ID']}")
    else
      @image = Docker::Image.build_from_dir('.')
      @image.tag(repo: 'invocaops/base', tag: 'test')
    end

    set :os, family: :ubuntu
    set :backend, :docker
    set :docker_image, @image.id
  end

  [
    'awk',
    'cut',
    'cron',
    'curl',
    'dig',      # dnsutils
    'git',
    'gpg',      # gnupg
    'grep',
    'head',
    'host',     # dnsutils
    'jq',
    'less',
    'lsof',
    'netcat-openbsd',
    'ngrep',
    'nslookup', # dnsutils
    'ping',
    'sed',
    'tail',
    'top',      # procps
    'tr',
    'vim',
  ].each do |pkg|
    describe command("which #{pkg}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file("/usr/lib/apt/methods/https") do
    it { is_expected.to exist }
    it { is_expected.to be_file }
  end
end
