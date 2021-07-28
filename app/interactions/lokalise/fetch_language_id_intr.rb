class Lokalise::FetchLanguageIdIntr < Lokalise::BaseIntr
  string :lang_iso

  def execute
    supervise_api_call do
      languages = client.project_languages(project_id)
      
      languages.collection.detect { |l| l.lang_iso == lang_iso }&.lang_id&.to_s
    end
  end
end
