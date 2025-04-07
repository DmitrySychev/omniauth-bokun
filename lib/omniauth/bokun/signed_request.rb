require 'openssl'

module OmniAuth
  module Bokun
    class SignedRequest
      attr_reader :params, :secret

      def initialize(params, secret)
        @params = params
        @secret = secret
      end

      def valid_signature?
        ActiveSupport::SecurityUtils.secure_compare(digest, hmac_value)
      end

      private

      def hmac_value
        hmac_value ||= CGI.unescape(params['hmac'].to_s)
      end

      def digest
        digest ||= OpenSSL::HMAC.hexdigest(
                    'sha256',
                    secret,
                    verification_string
                  )
      end


      def verification_params
        @verification_params ||= params.to_h
                                       .except('hmac', 'controller', 'action', 'format')
                                       .sort.to_h
      end

      def verification_string
        @verification_string ||= verification_params.map { |k, v| "#{k}=#{v}" }.join('&')
      end
    end
  end
end
