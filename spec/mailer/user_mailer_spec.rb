describe 'User mailer' do
  
  context "when a user is created" do
  
    let(:user){ FactoryGirl.build :user }
    
    it "triggers welcome email" do
      expect(Users::Creation::UserMailer).to receive(:welcome).and_call_original
      user.save
    end
    
  end 
  
end