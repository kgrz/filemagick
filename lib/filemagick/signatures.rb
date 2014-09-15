require 'yaml'
require 'singleton'

module Filemagick
  class Signatures
    include ::Singleton

    SIGNATURES_FILE = ::File.expand_path('../signatures.yml', __FILE__)
    attr_reader :signatures, :known_extensions, :known_mime_types

    def read_signatures_file!
      @signatures ||= YAML.load_file SIGNATURES_FILE
    end

    def known_mime_types
      read_signatures_file!

      @known_mime_types ||= @signatures.map { |sig| sig['mime'] }
    end

    def known_extensions
      read_signatures_file!

      @known_extensions ||= @signatures.map do |sig|
        sig['extensions']
      end.flatten
    end
  end
end
