## Emma API Wrapper (Ruby)
A Ruby wrapper for Emma's API.

## Running the tests [![Build Status](https://travis-ci.org/myemma/emma-wrapper-ruby.png)](https://travis-ci.org/myemma/emma-wrapper-ruby)
Set the following environment values

```bash
export EMMA_ACCOUNT_ID=123456
export EMMA_PUBLIC_KEY=6fbfd5e68d3306e51350
export EMMA_PRIVATE_KEY=53f42aa48e24d44a3362
```

Run the tests

```
bundle exec rake run_tests
```

## Installation

Add this line to your application's Gemfile:

    gem 'Emma'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Emma

## Usage

## Instantiation
```ruby
require 'Emma'
em = Emma::Setup.new 'account_id', 'public_key', 'private_key', 'debug_true_or_false'
```

You can also set environment variables and the Emma Wrapper will use them when you create an instance
```ruby
ENV['EMMA_ACCOUNT_ID'] = 'account_id'
ENV['EMMA_PUBLIC_KEY'] = 'public_key'
ENV['EMMA_PRIVATE_KEY'] = 'private_key'
em = Emma::Setup.new
```

## GET Request
```ruby
req = em.my_members
# Will return a members array
puts req.inspect
```

## Pagination
```ruby
req = em.my_members count: true
# Will return a count of all of the members tied to your account
puts req.inspect
```

```ruby
req = em.my_members start: 0, end: 200
# Will return a members array starting with the specified start param and ending with the specified end param
puts req.inspect
```

## POST Request
```ruby
req = em.add_member email: "helloworld@gmail.com", fields: { first_name: 'hello', last_name: 'world' }
# Will return a reference object of the newly added member
puts req.inspect
```

## PUT Request
```ruby
req = em.update_member 111, status: 'e'
# Will return true if the member was updated
puts req.inspect
``` 

## DELETE Request
```ruby
req = em.remove_member 111
# Will return true if the member was deleted
puts req.inspect
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
