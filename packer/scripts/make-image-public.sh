#!/bin/sh

# share image publicly
gcloud \
  compute \
    images \
      add-iam-policy-binding \
        "shipyard" \
        --member="allAuthenticatedUsers" \
        --role="roles/compute.imageUser"
