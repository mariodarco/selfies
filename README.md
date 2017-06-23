[![CircleCI](https://circleci.com/gh/mariodarco/selfies/tree/master.svg?style=shield)](https://circleci.com/gh/mariodarco/selfies/tree/master)

# Selfies
**A collection of macros for quicker development**

Another day at work, or on your personal project, and you need to create yet another class, which comes with the user boilerplate:
- The initialiser needs to be defined, with n parameters
- Inside that, the usual ```@param = param```, multiplied for how many params you've got there
- Then it's the turn of the attr_reader for those parameters
- Then you are likely to need a class method that does nothing else than initialising the class and calling an instance method of the same name
- more?

This gets boring with the years. So boring that someone might decide to write some macros to reduce the boilerplate.

## Disclaimer
In this project you will likely read me using both ```initialize``` and ```initialise```. I'm Italian, I learnt to code from American books and now live in UK, to me they both make sense. As a rule of thumb, it's the ```ize``` form in code and ```ise``` form everywhere else. But might mix them so bear with me. Thanks!


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'selfies'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install selfies
```

## Usage

***self_init***: can be used to automatically generate an initialiser for your class

This code:
```ruby
class Search
  self_init :term, :page, :limit
end
```

Is equivalent to:
```ruby
class Search
  attr_reader :term, :page, :limit

  def initialize(term, page, limit)
    @term = term
    @page = page
    @limit = limit
  end
end
```

***selfie***: can be used to automatically create a class method that reference to the instance method of the same class

This code:
```ruby
class Search
  attr_reader :term, :page, :limit

  def initialize(term, page, limit)
    @term = term
    @page = page
    @limit = limit
  end

  def self.execute!
    new(term, page, limit).execute!
  end

  def self.next
    new(term, page, limit).next
  end

  def execute!
    # does something
  end

  def next
    # does something else
  end
end
```

Can be written as:
```ruby
class Search
  self_init :term, :page, :limit

  def execute!
    # does something
  end
  selfie :execute!

  def next
    # does something else
  end
  selfie :next
end
```

If preferred, more methods can be 'selfied' in one liner, as long as the line is defined after them

```ruby
class Search
  ...

  def execute!
    # does something
  end

  def next
    # does something else
  end

  selfie :execute!, :next
end
```

## Next Steps

***self_init***: 
- Implement the possibility to pass defaults;
- Specify which parameters will get an attr_reader, attr_accessor or none;
- Specify wich parameters on attr_reader are to consider private;

***selfie***: 
- Allow the possibility to declare all selfies at the top (if possible);
- Find a suitable syntax that would allow to 'selfie' an instance method that has arguments;

***more?***:
- If you also often write repetitive bolierplate, and would like some code to get smaller, drop me a line and we might be able to add more macros.

## Development

Ruby version:
```
2.4.1
```

Fork the project, clone the repository and bundle:
```
>> git clone https://github.com/{your_account}/selfies.git
>> cd selfies
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mariodarco/selfies. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Selfies project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mariodarco/selfies/blob/master/CODE_OF_CONDUCT.md).
