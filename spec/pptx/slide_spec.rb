# frozen_string_literal: true

RSpec.describe Pptx::Slide do
  let(:file_path) { file_fixture("dummy.pptx") }
  let(:file) { File.read(file_path) }
  let(:document) { Pptx::Document.open(file) }
  let(:slide) { document.slides.first }

  describe "#content" do
    it "returns the content of the slide" do
      expect(slide.content).to eq(["This is a dummy title", "This is a dummy subtitle"])
    end
  end

  describe "#content=" do
    it "sets the content of the slide" do
      expect do
        slide.content = ["This is a new title", "This is a new subtitle"]
      end.to change { slide.content }
         .and change { slide.xml }

      expect(slide.content).to eq(["This is a new title", "This is a new subtitle"])
    end
  end
end
