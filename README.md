[![Code Climate](https://codeclimate.com/github/bguest/saneitized.png)](https://codeclimate.com/github/bguest/saneitized) [![Build Status](https://travis-ci.org/bguest/saneitized.png?branch=master)](https://travis-ci.org/bguest/saneitized) [![Coverage Status](https://coveralls.io/repos/bguest/saneitized/badge.png)](https://coveralls.io/r/bguest/saneitized) [![Gem Version](https://badge.fury.io/rb/saneitized.png)](http://badge.fury.io/rb/saneitized) [![Dependency Status](https://gemnasium.com/bguest/saneitized.png)](https://gemnasium.com/bguest/saneitized)

# Saneitized

Saneitized takes strings turns those values into their sane ruby equivalents. For example how many times have you done something like the following

    hash = JSON.parse("{\"should_explode\":\"false\"}")

    hash['should_explode']        #=> 'false'

    if hash['should_explode']
      explode_all_the_bombs       #=> 'Bombs are exploding'
    end

## Installation

Add this line to your application's Gemfile:

    gem 'saneitized'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install saneitized

## Usage

The guts of saneitized is it's convert method, it will converts strings into their appropriate types.
It tries to convert strings in the following order, trying the next thing if it fails or returning
the new value if it succeeds

    Boolean: Saneitized.convert('true') #=> true ('false' works the same way)
    nil:     Saneitized.convert('null') #=> nil  (also converts 'nil' and 'NULL')
    Integer: Saneitized.convert('42') #=> 42
    Float:   Saneitized.convert('22.2') #=> 22.2
    JSON:    Saneitized.convert("{\"hello\":\"goodbye\"}") #=> {"hello"=>"goodbye"}

Additionaly you can sanitize time as well

    Time:    Saneitized.convert("2014-05-28T23:15:26Z", :add => :time) #=> 2014-05-28 23:15:26 UTC

Time is left out of the default sanitizers because the Chronic parser used is pretty agressive and
will convert some things you might not thing would be time.

You can checkout `lib/saneitized/converter.rb` for more information

Saneitized ignores all non-string types except Arrays and Hashes.

### Arrays and Hashes

Arrays and hashes are recursively traversed and saneitized. So something like

    insane = [{'number' => '10'}, {'float' => '34.5'}]
    sane = Saneitized.convert(insane)              # Saneitized::Array.new(insane) is equivelent
    sane == [{'number' => 10}, {'float' => 34.5}] # Note this is a Saneitized::Array

Note that the returned types are Saneitized::Hash or Saneitized::Array, these function almost the same
as regular arrays except that new assigned values will also be saneitized

    hash = Saneitized::Hash.new
    hash['fred'] = '234'
    hash['fred'] #=> 234

### Saneitized Keys?

If for some reason you have a hash like `{'123' => 'foo', '124' => 'bar'}` and you want
to saneitze the keys of the hash, Sanitized allows you to do that too

    hash = {'123' => 'foo', '124' => 'bar'}
    sane = Sanitized.convert(hash, saneitize_keys: true)
    sane #=> {123 => 'foo', 124 => 'bar'}

### Blacklists

You can make saneitized ignore certain strings by including a blacklist option

    Saneitized.convert('23', blacklist:%w(21 22 23)) #=> '23'

You can also black list keys of hashes if thats your thing

    Saneitized.convert( {name:'12345', age:'21'}, :key_blacklist => :name}) #=> {name:'12345', age: 21}
    Saneitized.convert( {name:'12345', 'age' => '21'}, :key_blacklist => [:name, 'age'}) #=> {name:'12345', 'age' => '21'}

### Sanitizers

By default convert runs through the sanitizers, but you can pick and choose what sanitizers you want to use.

You can select to 'only' use certian converter

    Saneitized.convert( {a_float:'12.34', an_integer:'1234'}, :only => [:integer] ) #=> {a_float:'12.34', an_integer: 1234}

You can choose to use all the sanitizers 'except' a selection

    Saneitized.convert( {a_float:'12.34', an_integer:'1234'}, :except => :float ) #=> {a_float:'12.34', an_integer: 1234}

You can also add sanitizers that are overly agressive and not part of the default set

    Saneitized.convert( "2001-02-03 10:11:12 -0400", add: :time) #=> 2001-02-03 10:11:12 -0400

You can pass these options as a single symbol or as an array of symbols

### Important Notes

To convert a sanetized array/hash back to a non-saneitized hash, simply call the #to_a and #to_h
methods, but keep in mind that the resulting hash still points to the same underlying data, for
example.

    h = Sanetized::Hash.new({'key' => '10'})
    h #=> {'key' => 10}
    h['key'] = '20'
    h #=> {'key' => 20}
    hh = h.to_h
    hh['key'] = '30'
    h #=> {'key' => '30'}

This is how normal ruby arrays and hashes work as well, if you want a new copy, you need to
call dup.

#### NotImplementedError

If you run across a NotImplementedError with something that should works with a regular hash or
array, it's because I plan to implement the saneitized version, but haven't had a need for it yet,
you are welcome to submit pull requests that implements these holes.

### More Example

    sane_hash = Saneitized::Hash.new({:false =>  'false',
                                      :number => '10',
                                      :float  => '42.4'})

    sane_hash[:false]   #=> false
    sane_hash[:number]  #=> 10
    sane_hash[:float]   #=> 42.4

See the specs for more examples.

## Contributing

1. Fork it ( http://github.com//saneitized_hash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
2. Writes Specs, pull requests will not be accepted without tests.
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
