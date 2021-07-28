class Github::CreateBranchIntr < Github::BaseIntr
  string :branch_name

  validates :branch_name, presence: true

  def execute
    supervise_api_call do
      client.create_ref(repo, "refs/heads/#{branch_name}", sha)
    end
  end

  private

  def sha
    ref = client.ref(repo, Constant::MASTER_REF)
    ref.object.sha
  end
end
