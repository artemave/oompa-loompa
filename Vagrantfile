Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.box = 'trusty'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  config.vm.provision "docker"
  config.vm.provision "shell", inline: 'cd /vagrant && ./provision.sh'
end
