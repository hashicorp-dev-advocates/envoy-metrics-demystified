#!/bin/sh -ex

# verify Instruqt bootstrap has completed, see https://docs.instruqt.com/concepts/lifecycle-scripts/lifecycle-scripts-examples?q=
#until [ -f /opt/instruqt/bootstrap/host-bootstrap-completed ]; do
#  echo "Waiting for instruqt bootstrap to complete"
#  sleep 1
#done

# start shell with root privileges
# remove possibly outdated or competing Docker components
sudo dpkg \
  --remove \
    containerd \
    docker \
    docker-engine \
    docker.io \
    runc

# set up Docker Apt repository, see https://docs.docker.com/engine/install/ubuntu/
# Note that this is NOT a best-practices approach
echo "deb [trusted=yes] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# set up Shipyard Apt repository, see https://shipyard.run/docs/install/#debian-packages
# Note that this is NOT a best-practices approach
echo "deb [trusted=yes] https://apt.fury.io/shipyard-run/ /" | sudo tee /etc/apt/sources.list.d/fury.list > /dev/null

# update Apt cache
sudo apt-get update

# install packages
sudo apt-get \
  --yes \
  install \
    containerd.io \
    curl \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    git \
    nano \
    shipyard

# enable Docker service
sudo service docker start

# clone Shipyard blueprint
sudo git clone "https://github.com/hashicorp-dev-advocates/envoy-metrics-demystified.git" "/root/envoy-metrics-demystified"

# run shipyard to cache all Docker images and ensure everything looks good
sudo shipyard run "/root/envoy-metrics-demystified/shipyard"

# display status
sudo shipyard status

# destroy Blueprint to remove Shipyard services (while retaining Docker images)
sudo shipyard destroy
