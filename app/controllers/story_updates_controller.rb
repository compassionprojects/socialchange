# StoryUpdatesController
#
class StoryUpdatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story_update, only: %i[edit update destroy]

  # New story_update
  #
  def new
    @story_update = StoryUpdate.new(**creator, story_id: params[:story_id])
    authorize @story_update
  end

  # Create story_update
  #
  def create
    @story_update = StoryUpdate.new(**creator, story_id: params[:story_id])
    @story_update.assign_attributes(permitted_attributes(@story_update))
    authorize @story_update

    respond_to do |format|
      if @story_update.save
        # @todo change this to render show with created content
        format.html { head :created }
        format.json { render :show, status: :created, location: @story_update }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @story_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # edit story_update
  #
  def edit
    authorize @story_update
  end

  # update story_update
  #
  def update
    authorize @story_update
    respond_to do |format|
      if @story_update.update(**permitted_attributes(@story_update), updater: current_user)
        # @todo change this to render show with updated content
        format.html { head :no_content }
        format.json { render :show, status: :ok, location: @story_update }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @story_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # destroy story_update
  #
  def destroy
    authorize @story_update
    @story_update.discard
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_story_update
    @story_update = policy_scope(StoryUpdate).find(params[:id])
  end
end
