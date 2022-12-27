# Stories controller
#
class StoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit create update destroy]
  before_action :set_story, only: %i[show edit update destroy]

  def index
    @q = policy_scope(Story).ransack(params[:q])
    @stories = @q.result(distinct: true).page(params[:page])
  end

  def search
    index
    render :index
  end

  def show; end

  def new
    @story = Story.new(**creator)
    authorize @story
  end

  def edit
    authorize @story
  end

  def create
    @story = Story.new(**creator)
    @story.assign_attributes(permitted_attributes(@story))
    authorize @story

    respond_to do |format|
      if @story.save
        format.html { redirect_to story_url(@story), notice: I18n.t("stories.created") }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @story
    respond_to do |format|
      if @story.update(**permitted_attributes(@story), updater: current_user)
        format.html { redirect_to story_url(@story), notice: I18n.t("stories.updated") }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @story
    @story.discard

    respond_to do |format|
      format.html { redirect_to stories_url, notice: I18n.t("stories.deleted") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_story
    @story = policy_scope(Story).includes(:story_updates).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def story_params
    params.require(:story).permit(:title, :description, :outcomes, :source)
  end

  def creator
    { user: current_user, updater: current_user }
  end
end
