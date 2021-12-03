require 'rails_helper'

describe Booking do
  valid_attributes =
    {
      reservation: { code: 'XXX12345678',
                     start_date: '2021-03-12',
                     end_date: '2021-03-16',
                     status: 'accepted',
                     currency: 'AUD',
                     nights: 4,
                     guests: 4,
                     adults: 2,
                     children: 2,
                     infants: 0,
                     payout_price: '3800.00',
                     security_price: '500.00',
                     total_price: '4300.00',
                     localized_description: '4 guests' },
      guest: { first_name: 'Wayne',
               last_name: 'Woodbridge',
               phone: '639123456789,639123456789',
               email: 'wayne_woodbridge@bnb.com' }
    }

  describe '#call' do
    context 'when params are valid' do
      it 'should return valid reservation attributes' do
        params = JSON.parse(file_fixture('booking/booking_payload.json').read, symbolize_names: true)
        expect(described_class.call(params[:reservation])).to eq(valid_attributes)
      end
    end
  end
end
