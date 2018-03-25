require "rails_helper"

RSpec.describe ContactMessageMailer, type: :mailer do
  describe '#dispatch' do
    context "headers" do
      before do
        @contact_message = build(:contact_message)
        @mail = described_class.dispatch(@contact_message)
      end

      it "renders the subject" do
        expect(@mail.subject).to eq I18n.t('contact_message_mailer.dispatch.subject')
      end

      it "sends to the right email" do
        expect(@mail.to).to eq [ENV['ADMIN_EMAIL']]
      end

      it "renders the from email" do
        expect(@mail.from).to eq [@contact_message.email]
      end
    end

    it "includes the correct body with the user's message" do
      contact_message = build(:contact_message)
      mail = described_class.dispatch(contact_message)

      expect(mail.body.encoded).to include contact_message.body
    end
  end
end
