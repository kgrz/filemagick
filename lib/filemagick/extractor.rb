# This class handles the extraction of the starting set of bytes. If there
# are not enough bytes for the file type specified, an error is thrown
# mentioning the reason.

module Filemagick
  class Extractor
    attr_reader :file, :extracted_signature
    def_delegators :@signatures, :bytes_to_read_from_start, :starting_byte_offset

    def initialize(file)
      @file = file
      @signatures = Signatures.instance.for_file(file)
    end

    def process!
      # FIXME: check for eof after rewind to see if the file has any
      # bytes. Check if the file has enough bytes to figure out a
      # signature for the given extension
      begin
        read_starting_bytes!
      rescue EOFError => e
        raise Filemagick::Errors::CannotDetermineSignature
      rescue Errno::EINVAL => e
        raise Filemagick::Errors::CannotDetermineSignature
      ensure
        file.close
      end
    end

    def read_starting_bytes!
      file.rewind

      if starting_byte_offset
        file.seek(starting_byte_offset, IO::SEEK_CUR)
      end

      @extracted_signature =
        file.readpartial(bytes_to_read_from_start).unpack('H*').first
    end
  end
end
