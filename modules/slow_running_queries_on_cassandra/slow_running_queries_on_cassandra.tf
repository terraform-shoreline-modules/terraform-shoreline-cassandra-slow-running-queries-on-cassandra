resource "shoreline_notebook" "slow_running_queries_on_cassandra" {
  name       = "slow_running_queries_on_cassandra"
  data       = file("${path.module}/data/slow_running_queries_on_cassandra.json")
  depends_on = [shoreline_action.invoke_slow_query_analysis]
}

resource "shoreline_file" "slow_query_analysis" {
  name             = "slow_query_analysis"
  input_file       = "${path.module}/data/slow_query_analysis.sh"
  md5              = filemd5("${path.module}/data/slow_query_analysis.sh")
  description      = "Identify the queries that are running slowly and analyze their execution plans to determine the root cause of the issue. This could involve examining the query syntax, identifying any poorly optimized queries, or checking for inefficient use of indexes."
  destination_path = "/agent/scripts/slow_query_analysis.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_slow_query_analysis" {
  name        = "invoke_slow_query_analysis"
  description = "Identify the queries that are running slowly and analyze their execution plans to determine the root cause of the issue. This could involve examining the query syntax, identifying any poorly optimized queries, or checking for inefficient use of indexes."
  command     = "`chmod +x /agent/scripts/slow_query_analysis.sh && /agent/scripts/slow_query_analysis.sh`"
  params      = []
  file_deps   = ["slow_query_analysis"]
  enabled     = true
  depends_on  = [shoreline_file.slow_query_analysis]
}

