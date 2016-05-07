# docker-shadowcashd server

## Requirements

* Docker installed and running
  * [install Docker](https://docs.docker.com/engine/installation/)
* Server with memory and some free space (tested on Digital Ocean 2GB/2cpu server running CoreOS)

#### Howto

I'd expect you to have Docker set up. If not, try CoreOS. I'd recommend getting a droplet from DigitalOcean.
(Here's $10 referral link: https://www.digitalocean.com/?refcode=55a75462fc46).

Here's some instructions: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-coreos-cluster-on-digitalocean.

After that:

    ssh -A core@awesome.com
    git clone https://github.com/shadowproject/docker-shadowcashd.git
    cd docker-shadowcashd
    touch .env
    echo "export SHADOWCASHD_RPC_USER=some_user" >> .env
    echo "export SHADOWCASHD_RPC_PASSWORD=some_password" >> .env
    ./sdc build
    ./sdc init
    ./sdc run
    ./sdc rpc getinfo
    

Note: Inspect etc/env and see more overrides you can add to your custom .env

##### Stop

    ./sdc stop

##### Start

    ./sdc start

##### Upgrade

    ./sdc stop
    git pull
    ./sdc build
    ./sdc rm
    ./sdc run

##### RPC

    ./sdc rpc getinfo

note: if you get error about connection to shadowcashd, it may be that shadowcashd is reindexing/parsing 
blockchaing at the beginning. Give it some time after you run/start the container.

## Credits

* Inspiration from [binaryage's bitcoind-docker](https://github.com/binaryage/bitcoind-docker)

[Licensed under MIT](LICENSE)