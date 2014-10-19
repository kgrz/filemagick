# This class handles the responsibility of returning the Signature
# objects that match the mime type of the file. Ideally, this list of
# Signatures should have methods that will return the hexcodes and other
# information
module Filemagick
  class Signature
    def for_file(file)
      mime_types = MIME::Types.of(file).map(&:content_type)

      signature_objects = Signatures.instance.signatures.select do |mime, _|
        mime_types.member? mime
      end

      signature_objects.map { |_, signature| signature['hex_codes'] }
    end
  end
end
