require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Bokun < OmniAuth::Strategies::OAuth2
      option :name, "bokun"
      option :client_options, {
        :site => 'https://bokun.io',
        # bokun urls are dynamic based on the app name, need to figure this out 
        :authorize_url => '/appstore/oauth/authorize',
        :token_url => '/appstore/oauth/access_token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      def verify_hmac(params)
        # Remove hmac from params for verification
        hmac_value = params[:hmac]
        return false unless hmac_value.present?

        verification_params = params.except(:hmac).sort.to_h

        # Create the string to verify
        verification_string = verification_params.map { |k, v| "#{k}=#{v}" }.join('&')

        # Calculate HMAC
        digest = OpenSSL::HMAC.hexdigest(
          'sha256',
          ENV['BOKUN_SECRET'],
          verification_string
        )

        # Use constant-time comparison to prevent timing attacks
        ActiveSupport::SecurityUtils.secure_compare(digest, hmac_value)
      end
    end
  end
end
