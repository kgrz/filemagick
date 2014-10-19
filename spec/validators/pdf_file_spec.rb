require 'spec_helper'

module Filemagick
  describe File do
    let(:file) do
      described_class.new(pdf_file)
    end

    context 'Valid PDF' do
      let(:pdf_file) do
        ::File.expand_path('spec/fixtures/actual_pdf.pdf')
      end

      it 'should be valid' do
        expect(file.valid?).to be(true)
      end
    end

    context 'not enough bytes to read' do
      let(:pdf_file) do
        ::File.expand_path('spec/fixtures/empty_pdf.pdf')
      end

      it 'should not throw EOF' do
        expect{ file.valid? }.to raise_error(Filemagick::Errors::CannotDetermineSignature)
      end
    end

    context 'Invalid PDF' do
      let(:pdf_file) do
        ::File.expand_path('spec/fixtures/existing_file.txt')
      end

      it 'should be valid' do
        expect(file.valid?).to be(false)
      end
    end
  end
end
