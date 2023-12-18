class HealthController < ApplicationController
    def check
        # Perform some basic health checks, for example:
        db_alive = ActiveRecord::Base.connection.active? rescue false
        # binding.pry
        # Kredis::Connections
        # redis_alive = Redis.new.ping == 'PONG' rescue false
        
        # Prometheus::Client.registry.get(:db_health_status).set(1) if db_alive
        # Prometheus::Client.registry.get(:db_health_status).set(0) unless db_alive

        if db_alive # && redis_alive
          render json: { status: 'ok' }, status: :ok
        else
          render json: { status: 'error' }, status: :internal_server_error
        end
    end
end
