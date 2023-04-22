Vagrant.configure("2") do |config|
    servers=[
        {
          :hostname => "vm1",
          :ip => "192.168.56.11",
          :ssh_port => '2231',
          :box => "bento/ubuntu-18.04"
        },
        {
          :hostname => "vm2",
          :ip => "192.168.56.12",
          :ssh_port => '2232',
          :box => "bento/ubuntu-18.04"
        },
        {
          :hostname => "ansible-ctrl",
          :ip => "192.168.56.10",
          :ssh_port => '2230',
          :box => "bento/ubuntu-18.04"
        }
      ]

    servers.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = machine[:box]
            # next line avoids SSL error on Windows 10 while downloading box
            node.vm.box_download_insecure=true
            node.vm.hostname = machine[:hostname]
            node.vm.provision "shell", path: "provision-general.sh"
            node.vm.network :private_network, ip: machine[:ip]
            node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"
            node.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--memory", 512]
                vb.customize ["modifyvm", :id, "--cpus", 1]
            end
        end
    end
    config.vm.define "ansible-ctrl" do |node|
        node.vm.provision "shell", path: "provision-ansible.sh", privileged: false
    end
end