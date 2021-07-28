class Lokalise::CreateKeysIntr < Lokalise::BaseIntr
  hash :tool_spec, strip: false

  def execute
    supervise_api_call do
      client.create_keys(project_id, keys)
    end
  end

  private

  def keys
    Parser::TranslationKey.fetch(tool_spec)
  end
end
