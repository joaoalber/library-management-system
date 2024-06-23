module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      InsufficientParams = StandardError.new

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def logger
            Rails.logger
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error!({ message: "Resource not found", status: 404 }, 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error!({ message: e.message, status: 422 }, 422)
        end
      end
    end
  end
end
