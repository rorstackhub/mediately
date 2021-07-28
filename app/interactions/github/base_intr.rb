class Github::BaseIntr < BaseIntr

  private

  def repo
    ENV['GITHUB_REPO']
  end

  def client
    Octokit::Client.new(login: ENV['GITHUB_USERNAME'], password: ENV['GITHUB_PASSWORD'])
  end
end
