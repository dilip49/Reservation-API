require 'rails_helper'

describe AirBnb do
  valid_attributes =
    {
      reservation: { code: 'YYY123452222',
                     start_date: '2021-04-14',
                     end_date: '2021-04-18',
                     status: 'accepted',
                     currency: 'AUD',
                     nights: 4,
                     guests: 4,
                     adults: 2,
                     children: 2,
                     infants: 0,
                     payout_price: '4200.00',
                     security_price: '500',
                     total_price: '4700.00' },
      guest: { first_name: 'Wayne',
               last_name: 'Woodbridge',
               phone: '639123456789',
               email: 'test.wayne_woodbridge@bnb.com' }
    }
  describe '#call' do
    context 'when params are valid' do
      it 'should return valid reservation attributes' do
        params = JSON.parse(file_fixture('air_bnb/air_bnb_payload.json').read, symbolize_names: true)
        expect(described_class.call(params)).to eq(valid_attributes)
      end
    end
  end
end
