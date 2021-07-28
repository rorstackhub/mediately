class CreatePullRequestJob < ApplicationJob
  include Extensions::FetchContent

  def perform(tool_name, language, branch_name)
    filename = spec_filename(tool_name, language, "#{tool_name.upcase}.*.master.json")
    return if filename.blank?
    
    lang_id = Lokalise::FetchLanguageIdIntr.run!(lang_iso: language)
    keys = Lokalise::FetchKeysIntr.run!(lang_id: lang_id)
    
    Github::CreateBranchIntr.run!(branch_name: branch_name)

    content = Parser::ToolSpec.update(tool_spec(filename), keys)
  
    begin
      Github::CreateContentIntr.run!(tool_name: tool_name, language: language, branch_name: branch_name, content: content)

      Github::CreatePullRequestIntr.run!(tool_name: tool_name, language: language, branch_name: branch_name)
    rescue StandardError => exception
      Github::DeleteBranchIntr.run!(branch_name: branch_name)
      raise exception
    end
  end
end