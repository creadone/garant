# Garant

Gem help to prevents the collisions when generating a large number of hashes. For example you decided to try Ruby module `SecureRandom`:

```Ruby
require 'set'
require 'securerandom'

NUMBER_OF_HASHES = 1_000_000
STORAGE = Set.new

NUMBER_OF_HASHES.times do |num|
  STORAGE << SecureRandom.urlsafe_base64(4, false)
end

puts NUMBER_OF_HASHES - STORAGE.size # => 123
```

that is, out of 1 million approximately 123 hashes will be duplicated. It's OK if uniqueness is not the goal but sometimes it's necessary to get unique hashes from a specific hash-function (see [hash function quality and speed tests](https://github.com/rurban/smhasher)).

The Garant will make sure that there are no duplicates.

## Status

Working pre-alpha, not for production.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'garant'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install garant

## Usage

```Ruby
require 'garant'
require 'securerandom'

Garant.setup do |s|
  # Bloom filter params
  s.storage_type      = :bloom  # To store unique values will be used Bloom filter.
  s.expected_size     = 10_000  # Expected (or more) number of the hashes.
  s.error_probability = 0.01    # The probability of false positives.

  # Set params
  s.storage_type      = :set    # To store unique values will be used Set structure.

  # Common params
  s.max_retries       = 15      # The number of attempts to regenerate the not unique hash.
end

1000.times do
  puts Garant.safe{ SecureRandom.urlsafe_base64(4, false) }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/creadone/garant.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
