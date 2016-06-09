require 'spec_helper'

describe 'aufs::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('aufs::module')
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('aufs::package')
  end

  it 'includes other recipes' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('aufs::module')
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('aufs::package')
    chef_run
  end
end
