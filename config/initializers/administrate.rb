# Include extra assets required for adminiistrate
# Taken from https://github.com/thoughtbot/administrate/issues/187#issuecomment-220176073
#

Administrate::Engine.add_javascript "admin"
Administrate::Engine.add_stylesheet "admin"

# @todo customize dashboard path as well so that we can put all
# dashboards under administrate namespace
# app/administrate/dashboards/story.rb for example
