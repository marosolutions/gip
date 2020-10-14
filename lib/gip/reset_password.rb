# frozen_string_literal: true

class Gip::ResetPassword < Gip::Service
  Params = Struct.new(
    :email,
    :password,
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
      'email': email,
      'password': password
    }
  end
  
  def validate
    @errors << 'Email must be present' if email.blank?
    @errors << 'Password must be present' if password.blank?
  end

  def service_path
    return '/api/v1/accounts/update_user_password'
  end

  def request_type
    'PUT'
  end
end
