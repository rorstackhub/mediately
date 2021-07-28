class Lokalise::BaseIntr < BaseIntr

  private

  def project_id
    ENV['LOKALISE_PROJECT_ID']
  end

  def client
    Lokalise.client ENV['LOKALISE_API_KEY']
  end
end
