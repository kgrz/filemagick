require 'mime-types'
# This class handles the responsibility of returning the Signature
# objects that match the mime type of the file. Ideally, this list of
# Signatures should have methods that will return the hexcodes and other
# information
module Filemagick
  class Signature
    def self.for_file(file)
      mime_types = MIME::Types.of(file).map(&:extensions)
      extension = ::File.extname(file).gsub('.', '')

      signature_objects = Signatures.instance.signatures.select do |signature|
        signature["extensions"].member? extension
      end

      signature_objects.map { |signature| signature['signature'] }
    end
  end
end
