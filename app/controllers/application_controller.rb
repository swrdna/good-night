# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

    def render_json(resource, serializer: nil, status: :ok)
      if resource.is_a?(ActiveModel::Errors)
        render json: { message: resource.full_messages }, status: status
      else
        serializer ||= find_serializer(resource)
        render json: serializer.new(resource).serializable_hash, status: status
      end
    end

    def find_serializer(resource)
      controller_path = self.class.name.deconstantize
      model_name = resource.model_name.name
      namespaced_serializer = "#{controller_path}::#{model_name}Serializer".safe_constantize
      namespaced_serializer || "#{model_name}Serializer".constantize
    end
end
