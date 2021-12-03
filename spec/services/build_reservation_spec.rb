require 'rails_helper'

describe BuildReservation do
  air_bnb_valid_attributes = {
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

  booking_valid_attributes = {
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
    context 'When it receives air bnb params' do
      it 'should return valid attributes' do
        params = JSON.parse(file_fixture('air_bnb/air_bnb_payload.json').read, symbolize_names: true)
        expect(described_class.call(params)).to eq(air_bnb_valid_attributes)
      end
    end

    context 'when it recieves booking params' do
      it 'should return valid attributes' do
        params = JSON.parse(file_fixture('booking/booking_payload.json').read, symbolize_names: true)
        expect(described_class.call(params)).to eq(booking_valid_attributes)
      end
    end
  end
end
