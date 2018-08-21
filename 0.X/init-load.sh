#!/bin/bash
# Script starting and load common properties into consul instance

CONSUL_HOST=0.0.0.0
CONSUL_PORT=8500

echo "Starting Consul in dev mode..."
consul agent -dev -client $CONSUL_HOST -http-port $CONSUL_PORT > /tmp/consul/consul-agent.log &

# Wait until consul is up
until $(curl --output /dev/null --silent --head --fail $CONSUL_HOST:$CONSUL_PORT); do
    printf '.'
    sleep 1
done

echo -e "\bLoading init data..."
consul kv import @/tmp/init.json
echo "Done"
