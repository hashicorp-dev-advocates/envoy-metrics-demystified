#!/bin/sh

# see https://console.cloud.google.com/compute/instances?project=300991137417&supportedpurview=project
gcloud config set project "instruqt-shipyard"

gcloud auth application-default login
