

#!/bin/bash



# Set the necessary environment variables

export CASSANDRA_HOME=${PATH_TO_CASSANDRA_HOME_DIRECTORY}

export CQLSH_HOST=${CASSANDRA_HOST}



# Identify the queries that are running slowly

slow_queries=$(cqlsh $CQLSH_HOST -e "SELECT * FROM system_traces.sessions WHERE duration > 10000 ALLOW FILTERING;")



# Analyze the execution plans of the slow queries

for query in $slow_queries; do

    execution_plan=$(cqlsh $CQLSH_HOST -e "SELECT * FROM system_traces.events WHERE session_id=$query;")

    echo "Slow query: $query"

    echo "Execution plan: $execution_plan"

done