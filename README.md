
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Slow Running Queries on Cassandra
---

This incident type relates to identifying slow running queries on the Cassandra database and determining the users responsible for running them. Slow queries can cause performance issues and impact the overall efficiency of the system. Identifying and troubleshooting slow queries is crucial for maintaining optimal performance and ensuring smooth operations of the database. The incident may require investigating the root cause of the slow queries, optimizing the database configuration and queries, and providing recommendations to mitigate future incidents.

### Parameters
```shell
export CASSANDRA_SERVER_IP="PLACEHOLDER"

export THRESHOLD_IN_MICROSECONDS="PLACEHOLDER"

export SESSION_ID="PLACEHOLDER"

export DATABASE_NAME="PLACEHOLDER"

```

## Debug

### 1. Connect to the Cassandra database
```shell
cqlsh ${CASSANDRA_SERVER_IP}
```

### 2. Enable tracing of slow queries
```shell
TRACING ON;
```

### 3. Execute a query to identify slow running queries
```shell
SELECT * FROM system_traces.sessions WHERE duration > ${THRESHOLD_IN_MICROSECONDS};
```

### 4. Identify the user running the slow query
```shell
SELECT user FROM system_traces.events WHERE session_id = ${SESSION_ID};
```

### 5. Kill the slow query by session ID
```shell
KILL ${SESSION_ID};
```

## Repair

### Identify the queries that are running slowly and analyze their execution plans to determine the root cause of the issue. This could involve examining the query syntax, identifying any poorly optimized queries, or checking for inefficient use of indexes.
```shell


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


```