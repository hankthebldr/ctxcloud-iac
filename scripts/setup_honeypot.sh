#!/bin/bash

# Ensure environment variables for DShield email and API key are set
if [ -z "$DSHIELD_EMAIL" ] || [ -z "$DSHIELD_API_KEY" ]; then
  echo "Error: DSHIELD_EMAIL and DSHIELD_API_KEY environment variables must be set."
  exit 1
fi

# Create /etc/dshield.ini with provided email and API key
cat > /etc/dshield.ini <<EOF
[dshield]
email = $DSHIELD_EMAIL
apikey = $DSHIELD_API_KEY
EOF

# Update package list and install dependencies
apt update
apt install -y git python3 python3-pip

# Clone the DShield repository to /root/dshield
git clone https://github.com/DShield-ISC/dshield.git /root/dshield

# Run the DShield installation script
/root/dshield/bin/install.sh