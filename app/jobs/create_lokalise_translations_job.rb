class CreateLokaliseTranslationsJob < ApplicationJob
  include Extensions::FetchContent

  def perform(tool_name, language)
    return unless tool(tool_name, language)
    
    filename = spec_filename(tool_name, language, "#{tool_name.upcase}.#{language}.*.json")
    
    return destroy_tool(tool_name, language) if filename.blank?
    
    spec = tool_spec(filename)
    Lokalise::CreateKeysIntr.run!(tool_spec: spec)
    tool(tool_name, language).update!(spec: spec)
  end

  private

  def destroy_tool(tool_name, language)
    tool(tool_name, language).destroy
  end

  def tool(tool_name, language)
    @tool ||= Tool.find_by(name: tool_name, language: language)
  end
end