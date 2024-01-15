# frozen_string_literal: true

RSpec.describe PowerPointPptx::Document do
  let(:file_path) { file_fixture("dummy.pptx") }
  let(:file) { File.read(file_path) }

  describe "#open" do
    it "opens a pptx file" do
      expect { described_class.open(file) }.not_to raise_error
    end
  end

  describe "#slides" do
    it "returns an array of slides" do
      expect(described_class.open(file).slides).to be_a(Array)
      expect(described_class.open(file).slides.count).to eq(2)

      expect(described_class.open(file).slides.first).to be_a(PowerPointPptx::Slide)
    end
  end

  describe "#stream" do
    it "returns a stream of the pptx file" do
      document = described_class.open(file)
      slide = document.slides.first
      slide.content = ["This is a new title", "This is a new subtitle"]
      actual_result = document.stream

      expect(actual_result).to be_a(StringIO)

      new_file = save_stream_in_tmp_file(document.stream)

      new_document = described_class.open(File.read(new_file))
      expect(new_document.slides.first.content).to eq(["This is a new title", "This is a new subtitle"])
    end
  end
end
