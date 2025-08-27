class SourcesController < ApplicationController
  def index
    @sources = Source.all
    @source = if params[:source_id]
                source = Source.find(params[:source_id])
                source.like = 1 if source.like_id
              else
                Source.new
              end
  end

  def create
    @source = Source.new(source_params)

    if @source.save
      redirect_to sources_path
    else
      render "index"
    end
  end

  def update
    @source = Source.find(params[:id])
    @source.assign_attributes(source_params)

    if @source.save
      redirect_to sources_path
    else
      render "index"
    end
  end

  def destroy
    Source.find(params[:id]).destroy

    redirect_to sources_path
  end

  private

  def source_params
    params.require(:source).permit(:title, :amount)
  end
end
