require 'omniauth/strategies/oauth2'
require 'omniauth/bokun/signed_request'

module OmniAuth
  module Strategies
    class Bokun < OmniAuth::Strategies::OAuth2
      class NoAuthorizationCodeError < StandardError; end
      option :name, 'bokun'
      option :authorize_options, [:scope, :state, :redirect_uri]
      option :client_options, {
        authorize_url: '/appstore/oauth/authorize',
        token_url: '/appstore/oauth/access_token'
      }
      option :authorize_params, {
        scope: 'BOOKINGS_READ,BOOKINGS_WRITE,CUSTOMERS_READ,CUSTOMERS_WRITE',
        state: SecureRandom.hex(24),
        redirect_uri: "https://#{ENV['BOKUN_REDIRECT_DOMAIN']}/users/auth/bokun/callback"
      }
      option :token_params, {
        client_id: ENV['BOKUN_ID'],
        client_secret: ENV['BOKUN_SECRET']
      }

      uid { Base64.decode64(access_token.params['vendor_id']).split(':').last }

      info do
        {
          first_name: access_token.params['appInstalledByUserFirstName'],
          last_name: access_token.params['appInstalledByUserLastName'],
          email: access_token.params['appInstalledByUserEmail'],
          vendor_id: access_token.params['vendor_id'],
          scope: access_token.params['scope']
        }
      rescue NoMethodError
        Rails.logger.error "[Bokun] Failed to fetch user info from access token"
        {}
      end

      def client
        options.client_options.merge!(
          site: "https://#{subdomain}.#{domain}"
        )
        super
      end

      def request_phase
        unless OmniAuth::Bokun::SignedRequest.new(request.params, options.client_secret).valid_signature?
          Rails.logger.warn "[Bokun] HMAC verification failed"
          return fail!(:invalid_credentials)
        end
        super
      end

      def build_access_token
        token_params = options.token_params.merge(
          code: authorization_code,
          redirect_uri: callback_url
        )

        response = client.request(:post, options.client_options.token_url, {
          body: URI.encode_www_form(token_params),
          headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
        })

        parsed_response = JSON.parse(response.body)

        @access_token = ::OAuth2::AccessToken.from_hash(client, parsed_response)
      rescue ::OAuth2::Error => e
        Rails.logger.error "[Bokun] Token exchange failed: #{e.message}"
        Rails.logger.error "[Bokun] Response body: #{e.response.body}" if e.respond_to?(:response)
        raise e
      end

      def callback_url
        options.authorize_params[:redirect_uri] || super
      end

      private

      def authorization_code
        @authorization_code ||= request.params['code']
      end

      def session
        @session ||= request.session
      end

      def origin_host
        raw_origin = request.env['omniauth.origin'] || session['omniauth.origin']
        @origin_host ||= URI.parse(raw_origin.to_s).host
      rescue URI::InvalidURIError, NoMethodError
        nil
      end

      def domain
        @domain ||=
          if origin_host&.include?('bokuntest.com')
            'bokuntest.com'
          else
            'bokun.io'
          end
      end

      def subdomain
        # Yes, Bokun did not name their subdomain param properply. We can work with it :)
        @subdomain ||= request.params['domain']
      end
    end
  end
end
