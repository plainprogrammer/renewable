# Renewable

[![Code Climate](https://codeclimate.com/github/plainprogrammer/renewable/badges/gpa.svg)](https://codeclimate.com/github/plainprogrammer/renewable)
[![Build Status](https://travis-ci.org/plainprogrammer/renewable.svg)](https://travis-ci.org/plainprogrammer/renewable)
[![Test Coverage](https://codeclimate.com/github/plainprogrammer/renewable/badges/coverage.svg)](https://codeclimate.com/github/plainprogrammer/renewable)

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

*Don't write them!* This is where the idea of being more Functional comes into
play. Methods that modify the internal state of an object make it harder to
ensure the thread-safety of your code. But, so much of Object-Oriented
Programming is directly tied to mutation. Thankfully, with Renewable objects
that functionality is explicitly not available.

Instead, Renewable provides a method called `renew` that allows you to achieve
functionality similar to mutation, but without the same side effects. Instead
`renew` returns a completely new instance of the object, and you get control
over exactly what aspects of internal state change for the new instance.

The major downside to this is that you have to expect your mutator methods to
return a new instance, never just a value or nil. But, that's a pretty easy
idea to get used to.

#### #renew

The `renew` method is what you use to move beyond your frozen object, it accepts
two hashes: `attributes` and `options`. In that way, it is like calling `new`,
but it starts with the state of your frozen object and applies the changes you
specify.

```ruby
class Person
  #...

  def change_name(name)
    self.renew(name: name.to_s)
  end
end
```

That really is as simple as `renew` is in many cases. Because it accepts the
`attributes` and `options` arguments and calls `initialize` under the hood you
still get all the functionality of the callback handling when renewing objects.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/renewable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
