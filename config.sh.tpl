# Configurations for the server connection, including ip (required), tcp_port (required), user (optional) and password (optional) 
SRV_IP=
SRV_TCP_PORT=
SRV_USER=
SRV_PASSWORD=

#Parallel used for generating data, populate data, etc. optional, default: 1
PARALLEL=16

#Args to call clickhouse client. optional, default: <empty>
CLIENT_ARGS=

#Prefix of the database created
DB_PREFIX=

#Use engine time (-t from client). optional, default: false
ENABLE_ENGINE_TIME=false