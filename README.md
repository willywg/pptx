# PowerPointPptx

The goal of this gem is to be able to read and update powerpoint presentation pptx files.

This gem is heavily inspired by two other gems, [docx](https://github.com/ruby-docx/docx) and [ruby_powerpoint](https://github.com/pythonicrubyist/ruby_powerpoint).


## Installation

Add to your Gemfile
```
gem 'power_point_pptx'
```



## Usage

Example of usage

```
require 'power_point_pptx'

# Open an existing PowerPoint presentation
presentation = PowerPointPptx::Document.open('path/to/presentation.pptx')

# Get the first slide
slide = presentation.slides.first

# Retrieve content slide
slide.contents

# Change content

slide.contents = ["This is a new content]

# Stream the new version and save it in a temporary file

new_file = Tempfile.new
new_file.set_encoding("ASCII-8BIT")
new_file.write(presentation.stream.read)
new_file.rewind
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/test-IO/pptx. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/test-IO/pptx/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pptx project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/test-IO/pptx/blob/master/CODE_OF_CONDUCT.md).
