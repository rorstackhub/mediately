class Github::CreatePullRequestIntr < Github::BaseIntr
  string :language
  string :branch_name
  string :tool_name

  validates :branch_name, :tool_name, :language, presence: true

  def execute
    supervise_api_call do
      base = Constant::PULL_REQUEST_BASE
      client.create_pull_request(repo, base, branch_name, pr_title, pr_body)
    end
  end

  private

  def pr_title
    "#{tool_name} tool spec for #{language} language"
  end

  def pr_body
    "Please pull these #{language} traslations in!"
  end
end
