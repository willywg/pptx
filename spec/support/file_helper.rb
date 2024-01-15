# frozen_string_literal: true

def file_fixture(path)
  File.join(__dir__, "..", "fixtures", path)
end


def save_stream_in_tmp_file(stream)
  Tempfile.new.tap do |new_file|
    new_file.set_encoding("ASCII-8BIT")
    new_file.write(stream.read)
    new_file.rewind
  end
end


