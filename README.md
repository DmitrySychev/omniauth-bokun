# OmniAuth Bokun

Unofficial OmniAuth strategy for [23andMe](https://www.bokun.io/).

## Usage

In your initializer:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :bokun, {
    ENV['BOKUN_KEY'],
    ENV['BOKUN_SECRET'],
    scope: 'BOOKING_READ BOOKING_WRITE CUSTOMER_READ CUSTOMER_WRITE',
  }
end
```

Or, if you're using Devise, in your `Devise.setup`:

```ruby
config.omniauth :bokun, {
  ENV['BOKUN_KEY'],
  ENV['BOKUN_SECRET'],
  scope: 'BOOKING_READ BOOKING_WRITE CUSTOMER_READ CUSTOMER_WRITE'
}
```

Bokun API Scopes - https://bokun.dev/api/uzi4nXgs2wN1DhxkkLHves/access-scopes/nQZQgB7dthWzPeQ5hNzxvC

## Credits

Based on the exampe of [omniauth-github](https://github.com/omniauth/omniauth-github).

## License

Copyright (c) 2025 Dmitry Sychev

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
