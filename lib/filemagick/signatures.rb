require 'yaml'

module Filemagick
  class Signatures
    SIGNATURES_FILE = ::File.expand_path('../signatures.yml', __FILE__)
    attr_reader :signatures, :known_extensions, :known_mime_types

    def self.read_signatures_file!
      @@signatures ||= YAML.load_file SIGNATURES_FILE
    end

    def self.known_mime_types
      self.read_signatures_file!

      @@known_mime_types ||= @@signatures.map { |sig| sig['mime'] }
    end

    def self.known_extensions
      self.read_signatures_file!

      @@known_extensions ||= @@signatures.map do |sig|
        sig['extensions']
      end.flatten
    end
  end
end
