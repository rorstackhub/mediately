class Github::FetchPullRequestFilesIntr < Github::BaseIntr
  integer :number

  validates :number, presence: true

  def execute
    supervise_api_call do
      client.pull_request_files(repo, number)
    end
  end
end