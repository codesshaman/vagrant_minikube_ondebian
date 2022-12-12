# Vagrant virual machine with minikube

Your need install vagrant and virtualbox for up this configuration.

Your need install [vagrant](https://github.com/hashicorp/vagrant-installers/releases/tag/v2.3.4.dev%2Bmain "vagrant") and  [virtualbox](https://www.virtualbox.org/ "virtualbox") for up this configuration. Optional you can use [make](https://www.gnu.org/software/make/ "make").

### Step 1

Download box bento/debian-11 for virtualbox from [vagrantup](https://app.vagrantup.com/boxes/search "vagrantup").

### Step 2

Clonr this repository: git clone https://github.com/codesshaman/vagrant_minikube_ondebian.git

### Step 3

Copy box and go inside the repository folder:

``cp ~/Downloads/a22d1053-8311-450b-a740-6e3017c087f8 path_to/vagrant_minikube_ondebian/debian``

``cd vagrant_minikube_ondebian``

### Step 4

Inicialize configuration:

``vagrant box add bento/debian-11 debian``

or with make:

``make build``

### Step 5

Install configuration:

``vagrant up --provider=virtualbox``

or with make:

``make``

### Step 6

Connect:

``ssh vagrant@192.168.58.100``

or with make:

``make connect``

### Step 7

Start minikube:

``minikube start``
