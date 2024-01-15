# frozen_string_literal: true

require "nokogiri"

module Pptx
  # Represents a slide in a PowerPoint presentation.
  class Slide
    attr_reader :parsed_xml, :xml, :entry_name
    attr_accessor :xml

    def initialize(entry, entry_name)
      @entry_name = entry_name
      @xml = entry.get_input_stream.read
      @parsed_xml = Nokogiri::XML::Document.parse @xml
    end

    def content
      parsed_xml.xpath("//a:t").collect(&:text)
    end

    def content=(content)
      parsed_xml.xpath("//a:t").each_with_index do |node, index|
        node.content = content[index]
      end

      @xml = parsed_xml.to_xml
    end
  end
end
