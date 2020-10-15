require "gip/version"

module Gip
  class Error < StandardError; end
  
  class Gip::ConfigurationError < Gip::Error
    def message
      'Api key and host must exist'
    end
  end

  class << self
    attr_accessor :configuration

    def configure &blk
      self.configuration ||= Gip::Configuration.new.tap(&blk)
    end
  end

  class Configuration
    attr_accessor :host, :api_key

    def initialize(options={})
      self.host = options['host']
      self.api_key = options['api_key']
    end
  end

  class Service
    attr_reader :host, :url, :response_data, :response_status

    def initialize
      @host  = Gip.configuration&.host
      @api_key = Gip.configuration&.api_key
      raise Gip::ConfigurationError if !valid_for_execution
      @errors = []
    end

    def response
      execute
      return self
    end

    def errors
      @errors ||= []
    end

    def valid?
      errors.empty?
    end

    # def errors_hash
    #   { errors: errors }
    # end

    # def success_hash
    #   {}
    # end

    def request path, request_type, &blck
      url = @host+path
      url = URI(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = false
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      case request_type 
      when 'GET'
        request = Net::HTTP::Get.new(url)
      when 'POST'
        request = Net::HTTP::Post.new(url)
      when 'PUT'
        request = Net::HTTP::Put.new(url)
      else
        raise 'Invalid request type'
      end
  
      request["Authorization"] = @api_key
      request["content-type"] = 'application/json'
      yield(http, request)
    end

    def execute
      validate
      if valid?
        make_request
      end
    end

    def validate
    end

    def make_request
      request(service_path, request_type) do |http, request|
        request.body = payload.to_json
        process_request http, request
      end
    end

    def process_request http, request
      response = http.request(request)
      @response_status = response.code.to_i
      process_response(response.body)
    end

    def request_type
      raise 'Define request type in base class'
    end

    def service_path
      raise 'Define service path of API in base class'
    end

    private 

    def valid_for_execution
      !(@host.to_s.empty? || @api_key.to_s.empty?)
    end
  end
end

require "gip/sign_up"
require "gip/verify_token"
require "gip/reset_password"
require "gip/email_verification"
