require 'rails_helper'

describe Api::V1::ReservationsController, type: :controller do
  let!(:reservation) { FactoryBot.create(:reservation, code: 'YYY123453331') }

  describe '#create' do
    context 'when reservation payload type is AirBnb' do
      context 'on its success' do
        it 'should increase reservation count' do
          params = JSON.parse(file_fixture('air_bnb/air_bnb_payload.json').read, symbolize_names: true)
          post :create, params: params
          expect(Reservation.count).to eq(2)
        end
      end

      context 'on failure' do
        context 'when payload is invalid' do
          it 'should return error' do
            post :create, params: { "reservation": { "guest_email": 'test.wayne_woodbridge@bnb.com' } }
            error_message = JSON.parse(response.body)['message']
            expect(error_message).to match('Payload is invalid')
          end
        end

        context 'when reservation code is not unique' do
          it 'should update reservation update message' do
            params = JSON.parse(file_fixture('air_bnb/air_bnb_payload.json').read, symbolize_names: true)

            params[:reservation_code] = 'YYY123453331'
            post :create, params: params
            message = JSON.parse(response.body)['message']
            expect(message).to match('Reservation successfully updated')
          end
        end

        context 'when guest user email is not uniq' do
          let!(:guest) { FactoryBot.create(:guest, email: 'test.wayne_woodbridge@bnb.com') }
          let!(:reservation) { FactoryBot.create(:reservation, guest: guest) }

          it 'should return error' do
            params = JSON.parse(file_fixture('air_bnb/air_bnb_payload.json').read, symbolize_names: true)
            params[:email] = 'test.wayne_woodbridge@bnb.com'
            post :create, params: params

            error_message = JSON.parse(response.body)['message']
            expect(error_message).to match('Guest must exist')
          end
        end
      end
    end

    context 'when reservation payload type is booking' do
      context 'on its success' do
        it 'should increase reservation count' do
          params = JSON.parse(file_fixture('booking/booking_payload.json').read, symbolize_names: true)
          post :create, params: params
          expect(Reservation.count).to eq(2)
        end
      end

      context 'on failure' do
        context 'when payload is invalid' do
          it 'should return error' do
            post :create, params: { "reservation": { "code": 'XXX12345678' } }
            error_message = JSON.parse(response.body)['message']
            expect(error_message).to match('Payload is invalid')
          end
        end

        context 'when reservation code is not unique' do
          it 'should return error' do
            params = JSON.parse(file_fixture('booking/booking_payload.json').read, symbolize_names: true)
            params[:reservation][:code] = 'YYY123453331'
            post :create, params: params
            message = JSON.parse(response.body)['message']
            expect(message).to match('Reservation successfully updated')
          end
        end

        context 'when guest user email is not uniq' do
          let!(:guest) { FactoryBot.create(:guest, email: 'test.wayne_woodbridge@bnb.com') }
          let!(:reservation) { FactoryBot.create(:reservation, guest: guest) }

          it 'should return error' do
            params = JSON.parse(file_fixture('booking/booking_payload.json').read, symbolize_names: true)
            params[:reservation][:guest_email] = 'test.wayne_woodbridge@bnb.com'
            post :create, params: params

            error_message = JSON.parse(response.body)['message']
            expect(error_message).to match('Guest must exist')
          end
        end
      end
    end
  end
end
