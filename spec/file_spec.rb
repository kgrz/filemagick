require 'spec_helper'

module Filemagick
  describe File do
    context 'initialization' do
      let(:existing_file) { ::File.expand_path('spec/fixtures/existing_file.txt') }
      let(:nonexisting_file) { ::File.expand_path('spec/fixtures/non_existing_file.txt') }

      let(:file) do
        # TODO: What to do when the mime type is a text file?
        described_class.new(
          path_or_io: existing_file,
          expected_mime_type: 'image/jpeg'
        )
      end

      context 'String' do
        context 'Valid Path' do
          it 'initializes the IO handler' do
            expect(file.path).to eq(existing_file)
          end
        end

        context 'Invalid Path' do
          let(:file) do
            described_class.new(
              path_or_io: 'test',
              expected_mime_type: 'text'
            )
          end

          it 'throws proper error' do
            expect{ file }.to raise_error(Errno::ENOENT)
          end
        end
      end

      context 'IO' do
        let(:file) do
          described_class.new(
            path_or_io: ::File.new(existing_file),
            expected_mime_type: 'application/pdf'
          )
        end

        it 'initializes the object' do
          file
          expect(file.path).to eq(existing_file)
        end
      end
    end
  end
end
