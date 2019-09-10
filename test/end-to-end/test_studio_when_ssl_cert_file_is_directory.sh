#!/bin/bash

# Test that when SSL_CERT_FILE points to a directory, 
# that directory is not cached and communications with 
# Builder still function in the studio

set -euo pipefail

source .expeditor/scripts/end_to_end/shared_end_to_end.sh

echo "--- Generating a signing key"
hab origin key generate "$HAB_ORIGIN"

echo "--- Test Builder communications with SSL_CERT_FILE set to a directory"
tempdir="$(mktemp --tmpdir --directory e2e-ssl-XXXXXX)"

export SSL_CERT_FILE="${tempdir}"

hab studio rm
studio_run echo "SSL_CERT_FILE: \$SSL_CERT_FILE"
studio_run test ! -f \$SSL_CERT_FILE
studio_run hab pkg search core/vim

