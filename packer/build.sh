packer fmt .

packer \
  build \
    -force \
    -var-file="variables.pkrvars.hcl" \
    .
