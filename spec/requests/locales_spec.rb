require "rails_helper"

describe "Locales" do

  it "the default locale must be English" do
    expect(I18n.default_locale).to be :en
  end

  context "when a user is not signed in" do
    it "must set the locale to default locale" do
      get "/"
      expect(I18n.locale).to be I18n.default_locale
    end

    context "when browser locale is present" do
      it "must set the locale to browser locale" do
        get "/", headers: { "Accept-Language" => "nl-NL, nl;q=0.9, en;q=0.8" }
        expect(I18n.locale).to be :nl
      end

      it "must prioritize requested locale over browser locale" do
        get "/", params: { lang: :en }, headers: { "Accept-Language" => "nl-NL, nl;q=0.9, en;q=0.8" }
        expect(I18n.locale).to be :en
      end
    end

    context "when browser locale does not inculde supported locales" do
      it "must set the locale to default locale" do
        get "/", headers: { "Accept-Language" => "fr-CH, fr;q=0.9, en;q=0.8" }
        expect(I18n.locale).to be I18n.default_locale
      end
    end
  end

  context "when user is signed in" do
    let(:user) { create(:user, language: "nl", email: "test@example.com", password: 12345678, name: "test") }
    before(:each) do
      sign_in user
    end

    it "must set the locale to user's preferred language" do
      get "/"
      expect(I18n.locale).to be :nl
    end

    it "must set the locale to user's preferred language even when request headers are present" do
      get "/", headers: { "Accept-Language" => "en-US" }
      expect(I18n.locale).to be :nl
    end

    it "must choose the requested locale regardless of headers or preferred language" do
      get "/", params: { lang: "en" }, headers: { "Accept-Language" => "nl-NL" }
      expect(I18n.locale).to be :en
    end
  end
end
