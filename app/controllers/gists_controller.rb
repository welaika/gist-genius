class GistsController < ApplicationController
  respond_to :js

  def update
    @gist = Gist.find(params[:id])
    @gist.update(gist_params)

    respond_with @gist
  end

  private

  def gist_params
    params.require(:gist).permit(:id, :tag_list)
  end
end