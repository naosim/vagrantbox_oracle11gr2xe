VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.provision :shell, path: "provision.sh"
  config.vm.synced_folder "share/", "/share"
  config.vm.network :forwarded_port, guest: 1521, host: 1521
end
