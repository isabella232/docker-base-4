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
    'curl',
    'dig',      # dnsutils
    'git',
    'grep',
    'head',
    'host',     # dnsutils
    'jq',
    'less',
    'netcat',
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
end
