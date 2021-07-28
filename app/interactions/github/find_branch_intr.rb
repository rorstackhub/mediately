class Github::FindBranchIntr < Github::BaseIntr
  string :branch_name

  validates :branch_name, presence: true

  def execute
    supervise_api_call do
      client.ref(repo, branch_name)
    end
  end
end
