RSpec.describe OrdersController, type: :controller do
      
  describe '#checkout' do
        
    def the_action
      get :checkout, params: {id: order.id, journey_id: order.journey.id}
    end

    context "when a given order is reviewed by the parent who booked the teacher" do
      
      sign_as
    
      let(:journey){ FactoryGirl.create(:journey, user: user) }
      let(:order){ FactoryGirl.create(:order, journey: journey) }
      
      it "is possible to view the order" do
        the_action
        controller_ok(200) 
      end
      
    end
    
    context "when a given order is not reviewed by the parent who booked the teacher" do
    
      let(:order){ FactoryGirl.create(:order) }
      
      it "is not possible to view the order" do
        the_action
        controller_ok(302) 
      end
      
    end
    
  end 
    
end