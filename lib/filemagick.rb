require 'filemagick/signatures'

module Filemagick
  autoload :File,             'filemagick/file'
  autoload :Validator,        'filemagick/validator'
  autoload :Signature,        'filemagick/signature'
  autoload :Extractor,        'filemagick/extractor'
  autoload :Errors,           'filemagick/errors'

  INVALID_ARGUMENTS = <<EOS
'Wops! Must supply arguments as a hash with :file and :test_mime as
keys'
EOS

  def new(args = {})
    raise INVALID_ARGUMENTS unless args.is_a?(Hash)

    mime_type_expected = args.fetch(:test_mime)
    path_or_io = args.fetch(:file)

    File.new(path_or_io: path_or_io, expected_mime_type: mime_type_expected)
  rescue ::KeyError => e
    puts INVALID_ARGUMENTS
  end
  module_function :new
end
