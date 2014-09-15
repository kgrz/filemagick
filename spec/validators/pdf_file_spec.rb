require 'spec_helper'

module Filemagick
  describe File do
    let(:pdf_file) do
      ::File.expand_path('spec/fixtures/actual_pdf.pdf')
    end
    let(:file) do
      described_class.new(
        path_or_io: pdf_file,
        expected_mime_type: 'application/pdf'
      )
    end

    it 'should be valid' do
      expect(file.valid?).to be(true)
    end
  end
end
