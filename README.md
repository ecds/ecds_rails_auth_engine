# EcdsRailsAuthEngine

Rails engine for using token/signed cookie and FauxOAuth.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ecds_rails_auth_engine', git: 'https://github.com/ecds/ecds_rails_auth_engine.git', branch: 'feature/fauxoauth'
```

And then execute:

```bash
bundle install
```

## Configuration

Edit your `config/application.rb` by adding

```ruby
config.middleware.use(ActionDispatch::Cookies)
config.middleware.use(ActionDispatch::Session::CookieStore)
```

Create an initializer at `config/initializers/cookie_session.rb` and add the lines:

```ruby
Rails.application.config.session_store(:cookie_store, key: '<some_unique_name')
Rails.application.config.action_dispatch.cookies_serializer = :json
```

Make sure your `User` model has a column for `email`.

Mount the routes in your `config/routes.rb`

```ruby
mount EcdsRailsAuthEngine::Engine, at: '/auth'
```

## Usage

### CurrentUser

Include the `EcdsRailsAuthEngine::CurrentUser` controller concern to your `app/controllers/application.rb`

```ruby
class ApplicationController < ActionController::API
  include EcdsRailsAuthEngine::CurrentUser
  ...
end
```

This will add a `current_user` object in your controllers that is the `User` model object of the user making the request.


## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
