# frozen_string_literal: true

class Gip::User < Gip::Service
  Params = Struct.new(
    :email,
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
      'email': email
    }
  end
  
  def validate
    @errors << 'Email must be present' if email.blank?
  end

  def service_path
    return '/api/v1/accounts/user'
  end

  def request_type
    'GET'
  end
end
