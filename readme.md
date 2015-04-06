## what is this
This is a basic vagrant box. It installs the official ubuntu box and a 
iojs, docker, packer environment.  
You can easily disable the provisions in the `Vagrantfile`  

## Requirements
You must have a `virtualbox` and `vagrant` installation. Look [here](http://docs.vagrantup.com/v2/virtualbox) for instructions, and [here](http://www.vagrantup.com/downloads) and [here](https://www.virtualbox.org/wiki/Downloads) for download

## Install this vagrant box

- Download the box.
  ```bash
  [local]$ git clone --depth=1 https://github.com/markuz-brasil/iojs-docker-box
  [local]$ cd iojs-docker-box
  ```

- Install the box and ssh into the it.
  ```bash
  [local]$ vagrant up --no-provision && vagrant ssh
  ```

- Now you will be downloading Ubuntu's server image, it may take while.  
  The official `ubuntu box` will be installed and you should see something like
  this.

  ```
  Bringing machine 'default' up with 'virtualbox' provider...
  ==> default: Importing base box 'ubuntu-official'...
  ==> default: Matching MAC address for NAT networking...
  ==> default: Setting the name of the VM: iojs-docker-box_default_1419220263228_74237
  ==> default: Clearing any previously set forwarded ports...
  ==> default: Clearing any previously set network interfaces...
  ==> default: Preparing network interfaces based on configuration...
      default: Adapter 1: nat
      default: Adapter 2: hostonly
  ==> default: Forwarding ports...
      default: 22 => 2222 (adapter 1)
  ==> default: Running 'pre-boot' VM customizations...
  ==> default: Booting VM...
  ==> default: Waiting for machine to boot. This may take a few minutes...
      default: SSH address: 127.0.0.1:2222
      default: SSH username: vagrant
      default: SSH auth method: private key
      default: Warning: Connection timeout. Retrying...
      default: Warning: Remote connection disconnect. Retrying...
      default:
      default: Vagrant insecure key detected. Vagrant will automatically replace
      default: this with a newly generated keypair for better security.
      default:
      default: Inserting generated public key within guest...
      default: Removing insecure key from the guest if its present...
      default: Key inserted! Disconnecting and reconnecting using new SSH key...
  ==> default: Machine booted and ready!
  ==> default: Checking for guest additions in VM...
  ==> default: Configuring and enabling network interfaces...
  ==> default: Mounting shared folders...
      default: /vagrant => /Volumes/markuz-brasil/boxes/iojs-docker-box
      default: /tmp/vagrant-puppet-4/manifests => /Volumes/markuz-brasil/boxes/iojs-docker-box
  ==> default: Machine not provisioning because `--no-provision` is specified.
  Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-43-generic x86_64)

   * Documentation:  https://help.ubuntu.com/

   System information disabled due to load higher than 1.0

    Get cloud support with Ubuntu Advantage Cloud Guest:
      http://www.ubuntu.com/business/services/cloud

  0 packages can be updated.
  0 updates are security updates.


  vagrant@vagrant-ubuntu-trusty-64:~$
  ```

  If you got this far, this means that `Ubuntu`, `VirtualBox` and `Vagrant` are working
  well together and our `iojs-docker-box` is ready to be provisioned.

- But just to be sure, run `uname -v` on the guest

  ```bash
  vagrant@vagrant-ubuntu-trusty-64:~$ uname -v
  #72-Ubuntu SMP Mon Dec 8 19:35:06 UTC 2014
  ```

- exit box, reload it, and run provisions:

  - It may take a long while all provisions are being run.
  This is the place where `nodejs` and `mongodb` are downloaded and
  installed.
  You may go grab a coffee.

    ```bash
    vagrant@vagrant-ubuntu-trusty-64:~$ exit
    [local] $ vagrant reload --provision && vagrant ssh
    ==> default: Attempting graceful shutdown of VM...
    ==> default: Clearing any previously set forwarded ports...
    ==> default: Clearing any previously set network interfaces...
    ==> default: Preparing network interfaces based on configuration...
        default: Adapter 1: nat
                              ...  ...
    ```

  - and you should see something like this at the end.

    ```
                                ...  ...
    ==> default: Processing triggers for ureadahead (0.100.0-16) ...
    ==> default: Setting up mongodb-org (2.6.1) ...
    Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-29-generic x86_64)

     * Documentation:  https://help.ubuntu.com/

      System information as of Thu Jun 12 15:03:11 UTC 2014

      System load:  0.3               Processes:           96
      Usage of /:   2.7% of 39.34GB   Users logged in:     0
      Memory usage: 13%               IP address for eth0: 10.0.2.15
      Swap usage:   0%                IP address for eth1: 192.168.34.10

      Graph this data and manage this system at:
        https://landscape.canonical.com/

      Get cloud support with Ubuntu Advantage Cloud Guest:
        http://www.ubuntu.com/business/services/cloud

    0 packages can be updated.
    0 updates are security updates.

    - OS: Ubuntu 14.04 "trusty" server-amd64
    - NodeJS: stable (0.10.x) and latest (0.11.x)
    - Packer: stable (0.7.x)
    - Docker: stable (1.4.x)

    Last login: Thu Jun 12 15:02:22 2014 from 10.0.2.2
    vagrant@vagrant-ubuntu-trusty-64:~$
    ```

  - Simple testing.

    ```bash
    # Check if the shared directory is working and nodejs version.
    vagrant@vagrant-ubuntu-trusty-64:~$ ls /vagrant
    bootstrap.pp  provisions.sh  readme.md  Vagrantfile
    vagrant@vagrant-ubuntu-trusty-64:~$  node -v
    v0.10.34
    ```

    If your `/vagrant` directory is empty, this means you `guest additions` is not working.

    #### Congrats. Now you are set to go.

## vagrant cheatsheet:  

#### All vagrant commands need to be run within the box's shared folder.

```bash
# Turn the box on
[local]$ vagrant up

# Go inside the box
[local]$ vagrant ssh

# Exit the box
vagrant@vagrant-ubuntu-trusty-64:~$ exit

# turn the box off
[local]$ vagrant halt

# Delete the box
[local]$ vagrant destroy -f

# Bring the box up and go inside of it
[local]$ vagrant up && vagrant ssh

# Turn the box up and run provisions
[local]$ vagrant up --provision

# Bring the box up and **don't** run provisions.
# Useful on first time bringing the box up
[local]$ vagrant up --no-provision

# a equivalent for `vagrant halt && vagrant up`
[local]$ vagrant reload

# reload, re-provision, and go inside of the box
[local]$ vagrant reload --provision && vagrant ssh

```
