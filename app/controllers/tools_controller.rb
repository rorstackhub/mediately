class ToolsController < ApplicationController
  before_action :set_tool, only: :update

  def index
    @tools = Tool.with_spec
  end

  def new
    @tool = Tool.new
  end

  def create
    tool = Tool.new(tool_params) 
    if tool.save
      CreateLokaliseTranslationsJob.perform_later(tool_params[:name], tool_params[:language])
      flash[:notice] = t('tool.create')
    else
      flash[:error] = t('error')
    end

    redirect_to new_tool_path
  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    branch_outcome = Github::FindBranchIntr.run(branch_name: branch_name)
    
    if branch_outcome.valid?
      flash[:error] = t('api.branch_error')
    else
      CreatePullRequestJob.perform_later(@tool.name, tool_params[:language], branch_name)
      flash[:notice] = t('tool.update')
    end
    
    redirect_to new_tool_path
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :language)
  end

  def set_tool
    @tool = Tool.find(params[:id])
  end

  def branch_name
    "#{@tool.name}-#{tool_params[:language]}-spec"
  end
end
