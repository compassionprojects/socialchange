# Contributions controller
#
class ContributionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story
  before_action :set_contribution, only: %i[destroy]

  def new
    # use story policy update permissions
    authorize @story, :update?, policy_class: StoryPolicy

    @contribution = Contribution.new(story: @story)
  end

  def create
    # use story policy update permissions
    authorize @story, :update?, policy_class: StoryPolicy

    @story.invite_contributors(params[:contribution][:emails].split(","), current_user)
    @story.reload
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:story_contributors, partial: "stories/contributors",
          locals: {story: @story})
      end
      format.html { redirect_to story_url(@story), notice: I18n.t(".invited") }
      format.json { head :no_content }
    end
  end

  def destroy
    # use story policy update permissions
    authorize @story, :update?, policy_class: StoryPolicy

    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to story_url(@story), notice: I18n.t(".removed") }
      format.json { head :no_content }
    end
  end

  private

  def set_story
    @story = policy_scope(Story).find(params[:story_id])
  end

  def set_contribution
    @contribution = Contribution.find(params[:id])
  end
end
