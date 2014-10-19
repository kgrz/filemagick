# This class handles the extraction of the starting set of bytes. If there
# are not enough bytes for the file type specified, an error is thrown
# mentioning the reason.

require 'forwardable'

module Filemagick
  class Extractor
    extend Forwardable

    attr_reader :file, :extracted_signature
    def_delegator :@signature, :bytes_to_read_from_start, :starting_byte_offset

    def initialize(file, signatures)
      @file = file
      @signatures = signatures
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

    # This method returns the max number of bytes required to validate the
    # signature. That is, if an extension has multiple valid signatures, like
    # in the case of the jpeg and related file types, this method will return
    # the maximum number of bytes to out of all the bytes signatures to ensure
    # correct identification
    def bytes_to_read_from_start
      starting_hex_codes.map(&:length).max
    end

    def starting_byte_offset
      @signatures.first ? @signatures.first["offset"] : 0
    end

    def starting_hex_codes
      @signatures.first["hexcodes"]
    end
  end
end
