module Extensions
  module FetchContent
    extend ActiveSupport::Concern

    def spec_filename(tool_name, language, regex)
      Github::FindFilenameIntr.run!(name: tool_name, language: language, filename_regex: regex)
    end

    def tool_spec(filename)
      Github::FetchToolSpecIntr.run!(filename: filename)
    end
  end
end