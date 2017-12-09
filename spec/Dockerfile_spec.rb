require "serverspec"
require "docker"

describe "Dockerfile" do
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
    'dnsutils',
    'grep',
    'head',
    'jq',
    'less',
    'netcat',
    'ngrep',
    'nslookup',
    'ping',
    'sed',
    'tail',
    'top',
    'tr',
    'vim',
  ].each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end
