require 'spec_helper'

describe 'aufs::package' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  let(:apt_cache) { double }

  before(:each) do
    shellout = double
    allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
    allow(shellout).to receive(:run_command).and_return(apt_cache)
  end

  it 'installs package if package available and aufs missing' do
    allow(apt_cache).to receive(:stdout).and_return('linux-image-extra-3.13.0-66-generic - Description')
    stub_command('modprobe -n -v aufs').and_return(false)
    expect(chef_run).to install_package('linux-image-extra-3.13.0-66-generic')
  end

  it 'does not install package if package available and aufs present' do
    allow(apt_cache).to receive(:stdout).and_return('linux-image-extra-3.13.0-66-generic - Description')
    stub_command('modprobe -n -v aufs').and_return(true)
    expect(chef_run).to_not install_package('linux-image-extra-3.13.0-66-generic')
  end

  it 'does not install package if package unavailable and aufs missing' do
    allow(apt_cache).to receive(:stdout).and_return('')
    stub_command('modprobe -n -v aufs').and_return(false)
    expect(chef_run).to_not install_package('linux-image-extra-3.13.0-66-generic')
  end

  it 'does not install package if package unavailable and aufs present' do
    allow(apt_cache).to receive(:stdout).and_return('')
    stub_command('modprobe -n -v aufs').and_return(true)
    expect(chef_run).to_not install_package('linux-image-extra-3.13.0-66-generic')
  end
end
