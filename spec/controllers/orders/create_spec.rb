RSpec.describe OrdersController, type: :controller do
        
  def the_action(minutes)
    post :create, params: {order: { journey_id: journey.id, minutes: minutes } }
  end

  describe '#create' do
    
    let!(:reference){ FactoryGirl.create :order}

    context "when signed in" do
      
      sign_as
      
      let!(:car){ FactoryGirl.create :car, user: user }
      let!(:journey){ FactoryGirl.create :journey, car: car }
      
      context "for a new order is created" do
          
        it "works" do
          expect{the_action(reference.minutes)}.to change(Order, :count).by(1)
        end
        
      end
        
      context 'when no minutes are specified in the order' do
        
        it "doesn't create an order" do
          expect{the_action(0)}.to_not change(Order, :count)
        end
        
      end 
      
    end
      
    context "when signed out" do
      
      let(:journey){ FactoryGirl.create :journey}
      
      context "for a new order is created" do
          
        it "doesn't create an order" do
          expect{the_action(reference.minutes)}.to change(Order, :count).by(0)
        end
        
      end
      
    end
    
  end

end

