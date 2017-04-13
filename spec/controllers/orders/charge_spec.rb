RSpec.describe OrdersController, type: :controller do
      
  describe '#charge' do
              
    let(:stripeToken){ SecureRandom.hex }
    let(:order_params){
      {
        id: order.id,
        journey_id: order.journey.id,
        stripeToken: stripeToken
      }
    }
    
    def the_action
      post :charge, params: order_params
    end
    
    context "when signed in" do

      sign_as

      describe "paying an order I booked with teacher" do

        let(:journey){ FactoryGirl.create :journey, user: user}
        let(:order){ FactoryGirl.create :order, journey: journey}
        
        let(:amount_cents){ order.payable_amount_cents }
        let(:description){ order.charge_description }
        let(:currency){ Order::STRIPE_EUR }
        
        let(:result){ double }
        let(:stripe_charge_id) { SecureRandom.hex }

        context "Stripe success" do

          before do
            expect(Stripe::Charge).to receive(:create).with({
              amount: amount_cents,
              currency: currency,
              source: stripeToken,
              description: description
            }).and_return(result)
          end

          before do
            expect(result).to receive(:id).at_least(1).times.and_return stripe_charge_id
          end
          
          it "updates the order" do
            expect {
              the_action
            }.to change {
              order.reload.stripe_charge_id
            }.to(stripe_charge_id)
          end

        end

        context "when the Stripe result is unsuccessful" do

          before do
            expect(Stripe::Charge).to receive(:create).with({
              amount: amount_cents,
              currency: currency,
              source: stripeToken,
              description: description
            }).and_raise(Stripe::CardError.new('oops', 'oops', 'oops'))
          end

          it "doesn't update the order" do
            expect {
              the_action
            }.to_not change {
              order.reload.attributes.sort
            }
            controller_ok(302)
          end

          it "redirects to the path of the order again" do
            the_action
            expect(response).to redirect_to(order.payment_link)
          end

        end
      
        context "attempting to pay an order I booked with a teacher, which is already paid" do

          let!(:journey){ FactoryGirl.create :journey, user: user }
          let!(:order){ FactoryGirl.create :order, :paid, journey: journey }

          it "logs an error" do
            the_action
            expect(flash[:alert]).to eq "Already charged"
          end

        end

        context "attempting to pay an order I did not booked with a teacher" do

          let(:order){ FactoryGirl.create :order }

          it "doesn't update the order" do
            expect {
              the_action
            }.to_not change {
              order.reload.attributes.sort
            }
            controller_ok(302)
          end

        end
        
      end  

    end

    context "when signed out" do

      describe "attempting to pay any order" do

        let(:order){ FactoryGirl.create :order }

        it "doesn't update the order" do
          expect {
            the_action
          }.to_not change {
            order.reload.attributes.sort
          }
        end

      end

    end
  
  end

end
