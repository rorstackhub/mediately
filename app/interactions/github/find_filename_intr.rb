class Github::FindFilenameIntr < Github::BaseIntr
  string :name
  string :language
  string :filename_regex

  validates :name, :language, :filename_regex, presence: true

  def execute
    supervise_api_call do
      regex = Regexp.new(filename_regex)
      files = client.contents(repo, path: Constant::TOOL_SPEC_FOLDER)
      
      # Returned first matached file
      files.map { |file| file.name }.find { |e| regex =~ e }
    end
  end
end