require 'spec_helper'

describe 'aufs::module' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'loads aufs module' do
    expect(chef_run).to load_modules('aufs')
  end
end
