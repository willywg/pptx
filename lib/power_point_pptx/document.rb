# frozen_string_literal: true

require "nokogiri"
require "zip"

module PowerPointPptx
  class Document
    def self.open(file)
      new(file)
    end

    attr_reader :files

    def initialize(file)
      @files = Zip::File.open_buffer(file)
    end

    def slides
      @slides = []
      @files
        .select { |entry| entry.name.include?("ppt/slides/slide") }
        .map do |entry|
          @slides << Slide.new(entry, entry.name)
        end

      @slides
    end

    def stream
      stream = Zip::OutputStream.write_buffer do |out|
        @files.each do |entry|
          slide = @slides.find { |slide| slide.entry_name == entry.name }
          out.put_next_entry(entry.name)
          if slide.nil?
            out.write(entry.get_input_stream.read)
          else
            out.write(slide.xml)
          end
        end
      end

      stream.rewind
      stream
    end

    def save
      new_zip_file_path = Tempfile.new("new_pptx").path

      Zip::OutputStream.open(new_zip_file_path) do |new_zip_file|
        @files.each do |entry|
          slide = @slides.find { |slide| slide.entry_name == entry.name }
          new_zip_file.put_next_entry(entry.name)
          if slide.nil?
            new_zip_file.write(entry.get_input_stream.read)
          else
            new_zip_file.write(slide.xml)
          end
        end
      end

      File.new(new_zip_file_path)
    end

    private

    def commit_changes
      @files.each do |entry|
        slide = @slides.find { |slide| slide.entry_name == entry.name }
        entry.get_output_stream.write(slide.xml) unless slide.nil?
      end
    end
  end
end
