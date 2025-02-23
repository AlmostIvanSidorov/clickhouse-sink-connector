#!/bin/bash

# Source configuration
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/sink-connector-config.sh"

# clickhouse-sink-connector params

CLICKHOUSE_HOST="clickhouse"
CLICKHOUSE_PORT=8123
CLICKHOUSE_USER="root"
CLICKHOUSE_PASSWORD="root"
CLICKHOUSE_TABLE="employees"
CLICKHOUSE_DATABASE="test"

BUFFER_COUNT=10000

TOPICS="SERVER5432.test.employees_predated, SERVER5432.test.products, SERVER5432.transaction, SERVER5432.test.t1"
TOPICS_TABLE_MAP="SERVER5432.test.employees_predated:employees, SERVER5432.test.products:products"
#TOPICS="SERVER5432"

cat <<EOF | curl --request POST --url "${CONNECTORS_MANAGEMENT_URL}" --header 'Content-Type: application/json' --data @-
{
  "name": "${CONNECTOR_NAME}",
  "config": {
    "connector.class": "com.altinity.clickhouse.sink.connector.ClickHouseSinkConnector",
    "tasks.max": "3",
    "topics": "${TOPICS}",
    "clickhouse.topic2table.map": "${TOPICS_TABLE_MAP}",
    "clickhouse.server.url": "${CLICKHOUSE_HOST}",
    "clickhouse.server.user": "${CLICKHOUSE_USER}",
    "clickhouse.server.pass": "${CLICKHOUSE_PASSWORD}",
    "clickhouse.server.database": "${CLICKHOUSE_DATABASE}",
    "clickhouse.server.port": ${CLICKHOUSE_PORT},
    "clickhouse.table.name": "${CLICKHOUSE_TABLE}",
    "key.converter": "io.apicurio.registry.utils.converter.AvroConverter",
    "value.converter": "io.apicurio.registry.utils.converter.AvroConverter",

    "key.converter.apicurio.registry.url": "http://schemaregistry:8080/apis/registry/v2",
    "key.converter.apicurio.registry.auto-register": "true",
    "key.converter.apicurio.registry.find-latest": "true",

    "value.converter.apicurio.registry.url": "http://schemaregistry:8080/apis/registry/v2",
    "value.converter.apicurio.registry.auto-register": "true",
    "value.converter.apicurio.registry.find-latest": "true",
    "store.kafka.metadata": true,
    "topic.creation.default.partitions": 3,

    "store.raw.data": false,
    "store.raw.data.column": "raw_data",

    "metrics.enable": true,
    "metrics.port": 8084


  }
}
EOF

echo
