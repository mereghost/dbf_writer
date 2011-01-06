require 'bundler'
require 'metric_fu'
Bundler::GemHelper.install_tasks

MetricFu::Configuration.run do |config|
  config.metrics -= [:rcov]
end

