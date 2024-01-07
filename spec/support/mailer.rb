shared_examples "a notification email" do |subject_prefix, subject_key|
  it "sends an email to the user with the correct subject" do
    expect(mail.subject).to include(subject_prefix)
  end

  it "sends the email to the correct recipient" do
    expect(mail.to).to eq([user.email])
  end

  it "renders the body with the user and story information" do
    expect(mail.body.encoded).to include(user.name.split(" ").first)
    expect(mail.body.encoded).to include(story.title)
  end
end
