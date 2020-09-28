# Gip

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/gip`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gip'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gip

## Configuration

```ruby
 Gip.configure do |config|
    config.host = Rails.application.credentials[:host]
    config.api_key = Rails.application.credentials[:api_key]
 end
```

## Usage
Sign up
```ruby
    obj = Gip::SignUp.new({}).response
    => #<Gip::SignUp:0x000056122e64e6c8 @host="<Host name>", @api_key="<Api key>", @errors=["Email must be present", "Password must be present"], @params=#<struct Gip::SignUp::Params email=nil, password=nil, display_name=nil>>
    obj.errors
    ["Email must be present", "Password must be present"]

    obj = Gip::SignUp.new({email: 'homer@example.com', password: 'password'}).response
    
```
Verify token

```ruby
    obj = Gip::VerifyToken.new({}).response
    obj.errors
    ["Jwt token must be present"]

    obj = Gip::VerifyToken.new({jwt: '<token>'}).response   
    
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gip. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gip project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gip/blob/master/CODE_OF_CONDUCT.md).
