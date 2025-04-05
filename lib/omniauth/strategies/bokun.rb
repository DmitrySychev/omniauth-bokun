require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Bokun < OmniAuth::Strategies::OAuth2
      option :name, "bokun"
      option :scope, 'BOOKINGS_READ,BOOKINGS_WRITE,CUSTOMERS_READ,CUSTOMERS_WRITE'

      option :client_options, \
        site: 'https://bokun.io',
        authorize_url: '/appstore/oauth/authorize',
        token_url: '/appstore/oauth/access_token'
      # bokun urls are dynamic based on the app name, need to figure this out


      uid { raw_info['eid'] }

      info do
        raw_info
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/user/get').parsed['results']
      end

      def callback_url
        options[:callback_url]
      end

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
