describe SendContactMessageJob do
  describe '#perform' do
    it 'calls on the ContactMessageMailer' do
      msg = create(:contact_message)
      allow(ContactMessage).to receive(:find).and_return(msg)
      allow(ContactMessageMailer).to receive_message_chain(:dispatch, :deliver_now)
      described_class.new.perform(msg.id)

      expect(ContactMessageMailer).to have_received(:dispatch)
    end
  end

  describe '#perform_later' do
    it 'adds the job to the queue :mailers' do
      msg = create(:contact_message)
      allow(ContactMessageMailer).to receive_message_chain(:dispatch, :deliver_now)
      described_class.perform_later(msg.id)

      expect(enqueued_jobs.last[:job]).to eq described_class
    end
  end
end
