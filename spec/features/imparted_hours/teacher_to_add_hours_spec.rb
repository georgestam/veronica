describe "Submitting imparted hours" do 
  
  sign_as 
  
  let!(:car){ FactoryGirl.create :car, user: user }
  let!(:journey){ FactoryGirl.create :journey, car: car }
  let!(:reference){ FactoryGirl.create :imparted_hour, journey: journey }
    
  context 'when a new journey is created' do
    
    it 'can accept imparted hours' do
      visit dashboard_path
      find("a[data-target='#bookings']").click
      find("#imparted_hour_minutes").set reference.minutes
      find("#imparted_hour_date").set reference.date
      
      expect { 
        find('#submit-imparted-hours').click
      }.to change { 
        journey.reload.imparted_hours.count
      }.from(1).to(2)
    end 
      
  end
  
end