class ApiController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def parameter_missing(e)
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def record_not_found(e)
    render json: { error: e.message }, status: :not_found
  end
end
