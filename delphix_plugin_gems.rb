dir 'plugin_gems'
download "httpclient", "2.8.2.4"
if td_agent_2?
  download "aws-sdk", "2.11.68"
  download "fluent-plugin-s3", "0.8.7"
else
  download "jmespath", "1.4.0"
  download "aws-partitions", "1.149.0"
  download "aws-sigv4", "1.1.0"
  download "aws-sdk-core", "3.48.3"
  download "aws-sdk-kms", "1.16.0"
  download "aws-sdk-sqs", "1.13.0"
  download "aws-sdk-s3", "1.36.0"
  download "aws-sdk-cloudwatchlogs", "1.18.0"
  download "fluent-plugin-s3", "1.1.10"
  download "fluent-plugin-kinesis", "3.1.0"
end
if td_agent_2?
  download "thrift", "0.8.0"
  download "fluent-plugin-scribe", "0.10.14"
  download "bson", "4.1.1"
  download "mongo", "2.2.7"
  download "fluent-plugin-mongo", "0.8.1"
end
download "webhdfs", "0.8.0"
if td_agent_2?
  download "fluent-plugin-webhdfs", "0.7.1"
else
  download "fluent-plugin-webhdfs", "1.2.3"
end
if td_agent_2?
  download "fluent-plugin-rewrite-tag-filter", "1.6.0"
else
  download "fluent-plugin-rewrite-tag-filter", "2.2.0"
end
download "ruby-kafka", "0.7.6"
unless windows?
  download "rdkafka", "0.4.2"
end
download "fluent-plugin-kafka", "0.9.4"
unless td_agent_2?
  download "elasticsearch", "6.3.0"
  download "fluent-plugin-elasticsearch", "3.5.1"
  download "prometheus-client", "0.9.0"
  download "fluent-plugin-prometheus", "1.4.0"
end
if td_agent_2?
  download "fluent-plugin-record-modifier", "0.6.2"
else
  download "fluent-plugin-record-modifier", "2.0.1"
end
download "fluent-plugin-multi-format-parser", "1.0.0"
download "fluent-plugin-out-http", "1.2.0"
download "fluent-plugin-datadog", "0.10.5"
download "fluent-plugin-google-cloud", "0.7.11"
download "fluent-plugin-slack", "0.6.7"
download "fluent-plugin-grok-parser", "2.5.1"
download "fluent-plugin-dstat", "1.0.0"
download "fluent-plugin-cloudwatch-logs", "0.7.3"
download "fluent-plugin-influxdb", "2.0.0"
