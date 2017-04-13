describe Orders::Creation::Job do
  
  shared_examples "ok" do
    
    it "works" do
      expect(Orders::Creation::ParentNotificationMailer).to receive(:perform).at_least(1).times.and_call_original
      Orders::Creation::Job.perform_now order.class.to_s, order.id
    end
    
  end
  
  it_behaves_like "ok" do
    let(:order) { FactoryGirl.create(:order) }
  end
  
end
