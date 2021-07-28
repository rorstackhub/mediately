class Lokalise::FetchKeysIntr < Lokalise::BaseIntr
  string :lang_id

  def execute
    supervise_api_call do
      client.keys(project_id, { include_translations: 1, filter_translation_lang_ids: lang_id })
    end
  end
end
