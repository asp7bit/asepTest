class ApplicationController < ActionController::API
  def render_json_validation_error(resource)
    render json: resource, status: :bad_request, adapter: :json_api, serializer: ActiveRecord::Errors
  end
end
