require 'socket'
require 'prometheus/client'

# Get the hostname
hostname = Socket.gethostname

# Returns a default registry
prometheus = Prometheus::Client.registry

# Create a new counter metric with hostname as a label
http_requests = prometheus.get(:http_requests) || Prometheus::Client::Counter.new(:http_requests, 
                                                docstring: 'A counter of HTTP requests made', 
                                                labels: [:hostname])

# Register the metric only if it's not already registered
prometheus.register(http_requests) unless prometheus.get(:http_requests)

# Start using the counter
http_requests.increment(labels: { hostname: hostname })


# New metric for health check
db_health = Prometheus::Client::Gauge.new(:db_health_status, 'Database health status.')
prometheus.register(db_health)