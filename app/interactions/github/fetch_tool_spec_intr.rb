class Github::FetchToolSpecIntr < Github::BaseIntr
  string :filename

  validates :filename, presence: true

  def execute
    supervise_api_call do
      response = client.contents(repo, path: path_to_file)
      content = Base64.decode64(response.content)

      JSON.parse(content).with_indifferent_access
    end
  end

  private

  def path_to_file
    "#{Constant::TOOL_SPEC_FOLDER}/#{filename}"
  end
end
