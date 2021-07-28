class Github::CreateContentIntr < Github::BaseIntr
  string :branch_name
  string :tool_name
  string :language
  hash :content, strip: false

  validates :branch_name, :tool_name, :language, :content, presence: true

  def execute
    supervise_api_call do
      client.create_contents(repo, file_name, commit_message, content.to_json, branch: branch_name, sha: file_sha)
    end
  end

  private

  def file_sha
    client.contents(repo, path: file_name).sha rescue nil
  end

  def file_name
    "#{Constant::TOOL_SPEC_FOLDER}/#{tool_name.upcase}.#{language}.json"
  end

  def commit_message
    "#{language} traslations for tool #{tool_name}"
  end
end
