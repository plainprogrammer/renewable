# Renewable

Renewable provides means to have objects that are frozen by default. The benefit
of this is that it pushes the developer in the direction of a more Functional
style of programming that is safer in multi-threaded situations, but maintains
many of the benefits of Object-Oriented Programming's binding of data and
behavior by simply doing away with in-place mutation.

## STATUS

This code is still considered experimental in nature. It is not advised to use
this library in production environments without having read and fully
comprehended how the code works.

*YOU HAVE BEEN WARNED!*

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'renewable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install renewable

## Usage

Renewable exposes two usage approached: Mixin and Inheritance.

```ruby
class Person
  include Renewable

  attr_reader :name, :birth_date

  def age
    Date.today.year - birth_date.year
  end
end
```

```ruby
class Person < Renewable::Object
  attr_reader :name, :birth_date

  def age
    Date.today.year - birth_date.year
  end
end
```

Regardless of which you choose, the behavior is the same. Because of how
Renewable is intended to function there are some important rules to follow when
building your classes with Renewable.

### Initializers

*Don't write them!* Renewable implements an initializer that you can hook into
via callbacks. Because of the steps that the initializer takes need to be
preserved for everything to work properly you should simply avoid writing your
own. All of the callbacks described below will receive an `attributes` and an
`options` Hash, which are the two arguments the Renewable-supplied initializer
expects. Callbacks should simply be defined as `protected` or `private` methods
based on your inheritance needs.

```ruby
class Person < Renewable::Object
  attr_reader :name, :birth_date

  private

  def process_arguments(attributes, options)
    # This callback is invoked before Renewable does anything itself. So, do any
    # custom manipulation or processing of the attributes and options hashes you
    # need. This method should return an like so:
    return attributes, options
  end

  def before_freeze(attributes, options)
    # This callback is invoked immediately before Renewable freezes the object's
    # state. Prior to this step Renewable places each item in `attributes` into
    # its respective instance variable and stores `options` as well. This is
    # your last chance to modify the object's internal state. This method should
    # return like so:
    return attributes, options
  end

  def after_freeze(attributes, options)
    # This callback is invoked immediately after Renewable freezes the object's
    # state. At this point you can no longer mutate the object, but this
    # callback is provided just in case you find a use case. It is also the last
    # thing invoked by Renewable's initialize implementation and thus requires
    # no return value.
  end
end
```

### Mutators (Methods that change stuff)

TODO: Write this section.

### #renew

TODO: Write this section.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/renewable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
