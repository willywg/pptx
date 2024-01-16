# frozen_string_literal: true

require "nokogiri"
require "zip"

module PowerPointPptx
  # Represents a PowerPoint presentation.
  # This class is the main entry point for the gem.
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
          slide = @slides.find { |s| s.entry_name == entry.name }
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
  end
end
