# Filemagick

First basic version will have an interface where the user will provide
the expected extension by giving the mime type. The signatures are
fetched based on this mime type by fetching the entire list of
extensions and figuring out file-type specific identifiers in the
(usually) beginning of the file.

Later versions may contain absolute checking based on the extension of
the file fetched from the filename and the actual extension based on
magic number.

The steps for validation are this: (version 0.1)

1. Get the extension,
2. Figure out the list of hexcodes,
3. Get the sizes of the hexcodes and get the GCD,
4. Use the GCD to read that many bytes from the file provided,
5. Check to see if the bytes from the file correspond with the hexcodes,
6. Return true or false.

## Installation

Add this line to your application's Gemfile:

    gem 'filemagick'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filemagick

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/filemagick/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
