require 'serverspec'

set :backend, :exec

puts "os: #{os}"

describe command('/sbin/lsmod | grep ^aufs') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^aufs/) }
end
