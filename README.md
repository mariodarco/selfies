![Gem Version](https://badge.fury.io/rb/selfies.svg) ![Build Status](https://gitlab.com/mariodarco/selfies/badges/master/build.svg) ![Coverage report](https://gitlab.com/mariodarco/selfies/badges/master/coverage.svg?job=coverage)

# Selfies
**A collection of macros for quicker development**

Another day at work, or on your personal project, and you need to create yet another class, which comes with the user boilerplate:
- The initialiser needs to be defined, with n parameters
- Inside that, the usual ```@param = param```, multiplied for how many params you've got there
- Then it's the turn of the attr_reader for those parameters
- Then you are likely to need a class method that does nothing else than initialising the class and calling an instance method of the same name
- more?

This gets boring with the years. So boring that someone might decide to write some macros to reduce the boilerplate.

## TL;DR

You add this:
```ruby
gem 'selfies'
```

You write this:
```ruby
class Rectangle
  attr_accessor_init :width, :height, scale: 100
  selfie :area, :perimeter

  def area
    proportion(width * height)
  end

  def perimeter
    proportion((width + height) * 2)
  end

  private

  def proportion(value)
    value.to_f / 100 * scale
  end
end
```

You get this:
```ruby
>> Rectangle.area(8, 4)
=> 32.0
>> Rectangle.perimeter(5, 3)
=> 16.0
>> Rectangle.perimeter(5, 3, 50)
=> 8.0
```

## Disclaimer
In this project you will likely read me using both ```initialize``` and ```initialise```. I'm Italian, I learnt to code from American books and now live in Ireland, to me they both make sense. As a rule of thumb, it's the ```ize``` form in code and ```ise``` form everywhere else. But might mix them so bear with me. Thanks!


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

***attr_reader_init***: can be used to automatically generate an initialiser for your class

This code:
```ruby
class Search
  attr_reader_init :term, :page, :limit
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

It is possible to specify a default for the last argument only:

This code:
```ruby
class Search
  attr_reader_init :term, :page, limit: 5
end
```

Is equivalent to:
```ruby
class Search
  attr_reader :term, :page, :limit

  def initialize(term, page, limit = 5)
    @term = term
    @page = page
    @limit = limit
  end
end
```

```ruby
>> search = Search.new('foo', 1)
>> search.limit
=> 5
```

You can use any variable name that would make for a valid Ruby variable;
Only exception is ```:args``` which is used by ```selfies``` to define a splat operator:

This code:
```ruby
class Search
  attr_reader_init :term, :args
end
```

Is equivalent to:
```ruby
class Search
  attr_reader :term, :args

  def initialize(term, *args)
    @term = term
    @args = args
  end
end
```

```ruby
>> search = Search.new('foo', 2, 10)
>> search.args
=> [2, 10]
```

***attr_accessor_init***: same as ```attr_reader_init```, but generates accessors for the given attributes

This code:
```ruby
class Search
  attr_accessor_init :term, :page, :limit
end
```

Is equivalent to:
```ruby
class Search
  attr_accessor :term, :page, :limit

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

  def self.execute!(term, page, limit)
    new(term, page, limit).execute!
  end

  def self.next(term, page, limit)
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
  attr_reader_init :term, :page, :limit

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

If preferred, more methods can be 'selfied' in one liner:
```ruby
class Search
  ...
  selfie :execute!, :next

  def execute!
    # does something
  end

  def next
    # does something else
  end
end
```

## Next Steps

***attr_reader_init*** and ***attr_accessor_init:***
- Improve message when raising ArgumentError;

***selfie:***
- Find a suitable syntax that would allow to 'selfie' an instance method that has arguments;

***command line:***
- Write a command that can initialize a whole class, from creating the file to stub the initial setup;

***more?:***
- If you also often write repetitive bolierplate, and would like some code to get smaller, drop me a line and we might be able to add more macros.

## Development

Ruby version:
```bash
2.5.1
```

Fork the project, clone the repository and bundle:
```bash
>> git clone https://{your_fork}/selfies
>> cd selfies
>> bundle
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitLab at https://gitlab.com/mariodarco/selfies. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

