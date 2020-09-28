# frozen_string_literal: true

class Gip::VerifyToken < Gip::Service
  Params = Struct.new(
    :jwt,
    keyword_init: true
  )

  delegate_missing_to :@params

  def initialize params
    super()
    @params = Params.new(params.to_h)
  end

  def process_response resp
    @response_data = JSON.parse(
      resp, 
      object_class: OpenStruct
    )
  end

  private
  
  def payload
    return {
      'jwt': jwt
    }
  end
  
  def validate
    @errors << 'Jwt token must be present' if jwt.blank?
  end

  def service_path
    return '/api/v1/accounts/verify_token'
  end

  def request_type
    'POST'
  end
end
