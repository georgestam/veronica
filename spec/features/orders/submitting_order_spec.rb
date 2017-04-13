describe 'Submitting an Order', js: true do
  
  sign_as 
  
  let!(:car){ FactoryGirl.create :car, user: user }
  let!(:journey){ FactoryGirl.create :journey, car: car }
  let!(:imparted_hour){ FactoryGirl.create :imparted_hour, journey: journey }
  let!(:reference){ FactoryGirl.create :order, journey: journey }
    
  context 'when minutes are filled' do
    
    it 'creates a new order' do
      visit dashboard_path
      find("a[data-target='#bookings']").click
      find("#submit-order").click
      find("#order_minutes").set reference.minutes
      
      expect { 
        find('#create-order').click
      }.to change { 
        journey.orders.reload.count
      }.from(1).to(2)
    end 
      
  end
  
end