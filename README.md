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

Use it like so

    sane_hash = Saneitize::Hash.new({:false =>  'false',
                                     :number => '10',
                                     :float  => '42.4'})

    sane_hash[:false]   #=> false
    sane_hash[:number]  #=> 10
    sane_hash[:float]   #=> 42.4

See the specs for more examples.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/saneitized_hash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
