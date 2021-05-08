#!/bin/sh

echo "Docker started at: $(date)"

# [ "$1" = "--use-env" ] && {
#   # Generate new env.json based on ENV variables
#   cat /app/env.json | \
#     jq --arg var $(echo [\"$ORIGIN_WHITELIST\"] | sed 's/,/","/') '.OriginWhitelist=$var' | \
#     jq --arg var $(echo [\"$DESTINATION_WHITELIST\"] | sed 's/,/","/') '.DestinationWhitelist=$var' | \
#     jq --arg var $LISTEN_HOST '.ListenHost=$var' | \
#     jq --arg var $LISTEN_PORT '.ListenPort=$var' > /app/env.json.tmp
#   mv /app/env.json.tmp /app/env.json
# }

# Dos2unix & chmod files
echo "* Running dos2unix on files"
find /app -type f \( -iname "*.sh" -or -iname "*.json" \) -print0 | xargs -0 dos2unix
echo "* Running chmod on files"
find /app -type f -iname '*.sh' -exec chmod -v 755 {} +

echo "Node started at: $(date)"

# Start server
cd /app
touch /var/log/ninjakatt.log
node index.js | tee -a /var/log/ninjakatt.log
