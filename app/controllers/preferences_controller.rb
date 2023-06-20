# Preferences controller
#
class PreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_preference, only: %i[index update]

  def index
  end

  def update
    respond_to do |format|
      if @preference.update(**permitted_params)
        format.html { redirect_to preferences_url, notice: I18n.t("preferences.updated") }
        format.json { render :index, status: :ok, location: @preference }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_preference
    @preference = current_user.preference
  end

  def permitted_params
    params.require(:preference).permit(
      :notify_any_post_in_discussion,
      :notify_new_discussion_on_story,
      :notify_new_post_on_discussion,
      :notify_new_story
    )
  end
end
