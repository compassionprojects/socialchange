RSpec::Matchers.define :have_translation do |locale|
  match do |actual|
    actual.translation?(locale)
  end
end
