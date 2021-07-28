class UpdateToolSpecJob < ApplicationJob

  def perform(pr_number, branch_name)
    files = Github::FetchPullRequestFilesIntr.run!(number: pr_number)
    
    return if files.count > 1
    
    filename = files.first.filename.split('/').last   
    tool_spec = Github::FetchToolSpecIntr.run!(filename: filename)
    
    tool = Tool.find_or_initialize_by(tool_params(filename))
    tool.spec = tool_spec
    tool.save!
    
    Github::DeleteBranchIntr.run!(branch_name: branch_name)
  end

  private

  def tool_params(filename)
    filename =  filename.split('.')
    
    {
      name: filename.first.downcase,
      language: filename.second
    }
  end
end