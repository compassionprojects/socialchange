# commands used to deploy a Rails application
namespace :fly do
  # RELEASE step:
  #  - changes to the fs make here are DISCARDED
  #  - access secrets, databases
  #  - Failures here prevent deployment
  task release: "db:migrate"
end
