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

The guts of sanitized is it's convert method, it will converts strings into their approprate types.
It tries to convert strings in the following order, trying the next thing if it fails or returning
the new value if it succeeds

    Boolean: Saneitized.convert('true') #=> true ('false' works the same way)
    nil:     Saneitized.convert('null') #=> nil  (also converts 'nil' and 'NULL')
    Integer: Saneitized.convert('42') #=> 42
    Float:   Saneitized.convert('22.2') #=> 22.2
    JSON:    Saneitized.convert("{\"hello\":\"goodbye\"}") #=> {"hello"=>"goodbye"}
    Time:    Saneitized.convert("2014-05-28T23:15:26Z") #=> 2014-05-28 23:15:26 UTC

You can checkout `lib/saneitized/converter.rb` for more information

Sanetized ignores all non-string types except Arrays and Hashes.

### Arrays and Hashes

Arrays and hashes are recursivly traversed and saneitized. So something like

    insane = [{'number' => '10'}, {'float' => '34.5'}]
    sane = Sanitized.convert(insane)              # Sanitized::Array.new(insane) is equivelent
    sane == [{'number' => 10}, {'float' => 34.5}] # Note this is a Sanitized::Array

Note that the returned types are Saneitized::Hash or Saneitized::Array, these function almost the same
as regular arrays except that new assigned values will also be saneitized

    hash = Saneitized::Hash.new
    hash['fred'] = '234'
    hash['fred'] #=> 234

### Blacklists

You can make sanitized ignore certain strings by includeing a blacklist option 

   Sanitized.convert('23', blacklist:%w(21 22 23)) => '23'

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

1. Fork it ( http://github.com/<my-github-username>/saneitized_hash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
2. Writes Specs, pull requrests will not be accepted without tests.
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
