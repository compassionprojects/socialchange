# Contributions controller
#
class ContributionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story
  before_action :set_contribution, only: %i[destroy]

  def create
    # use story policy update permissions
    authorize @story, :update?, policy_class: StoryPolicy

    @story.invite_contributors(params[:emails], current_user)
    respond_to do |format|
      format.html { redirect_to story_url(@story), notice: I18n.t("stories.contributors_invited") }
      format.json { head :no_content }
    end
  end

  def destroy
    # use story policy update permissions
    authorize @story, :update?, policy_class: StoryPolicy

    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to story_url(@story), notice: I18n.t("stories.contributor_removed") }
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
