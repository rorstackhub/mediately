class GithubWebhooksController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include GithubWebhook::Processor

  def github_pull_request(payload)
    return unless payload['action'].eql?('closed') && payload['pull_request']['merged']
    
    number = payload['pull_request']['number']
    branch_name = payload['pull_request']['head']['ref']
    
    UpdateToolSpecJob.perform_later(number, branch_name)
  end


  private

  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end
end