require 'spec_helper'

module Filemagick
  describe File do
    let(:file) do
      described_class.new(
        path_or_io: jpeg_file,
        expected_mime_type: 'image/jpeg'
      )
    end

    context 'Valid JPEG' do
      let(:jpeg_file) do
        ::File.expand_path('spec/fixtures/actual_jpeg.jpg')
      end

      it 'should be valid' do
        expect(file.valid?).to be(true)
      end
    end

    context 'not enough bytes to read' do
      let(:jpeg_file) do
        ::File.expand_path('spec/fixtures/empty_jpeg.jpg')
      end

      it 'should not throw EOF' do
        expect{ file.valid? }.to raise_error(Filemagick::Errors::CannotDetermineSignature)
      end
    end

    context 'Invalid JPEG' do
      let(:jpeg_file) do
        ::File.expand_path('spec/fixtures/existing_file.txt')
      end

      it 'should be valid' do
        expect(file.valid?).to be(false)
      end
    end
  end
end
