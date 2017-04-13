describe Order do
  
  describe 'Creation' do
  
    context "when an instance of this class becomes persisted" do
    
      subject(:creation) { FactoryGirl.create(:order) }
      
      it "triggers a Orders::Creation::Job" do
        expect(Orders::Creation::Job).to receive(:perform_now).with(described_class.to_s, anything)
        creation
      end
      
    end
  
  end
  
end