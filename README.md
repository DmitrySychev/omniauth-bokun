# Omniauth::Bokun

This is the unofficial OmniAuth strategy for authenticating to Bokun. To use it, you'll need to sign up for Bokun account and set up an application in their developer portal to get your API key and secret. [Bokun.io](https://www.bokun.io/)

* This is an in development version of the gem, and it may not be fully functional yet.
TODO: Add tests
TODO: Make scopes configurable

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-bokun'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-bokun

## Usage

The gem expect three environment variables to be set:
- `BOKUN_ID`: Your Bokun application API key (Client ID)
- `BOKUN_SECRET`: Your Bokun application secret key (Client Secret)
- `BOKUN_REDIRECT_DOMAIN`: The URL where Bokun will redirect after authentication. Since Bokun assigns a dynamic domain based on your company name, you need to set this in order for the callback to work.


# If using without Devise
``` ruby
use OmniAuth::Builder do
  provider :bokun, ENV['BOKUN_ID'], ENV['BOKUN_SECRET']
end
```

# If using with Devise

In your `config/initializers/devise.rb`, add the following:

```ruby
config.omniauth :bokun, ENV['BOKUN_ID'], ENV['BOKUN_SECRET']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dmitry.sychev/omniauth-bokun. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

Copyright (c) 2025 Dmitry Sychev

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Code of Conduct

Everyone interacting in the Omniauth::Bokun project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/omniauth-bokun/blob/master/CODE_OF_CONDUCT.md).
