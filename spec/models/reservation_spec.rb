require 'rails_helper'

describe Reservation do
  let!(:reservation_1) { FactoryBot.create(:reservation, code: 'YYY1234511112') }

  it 'is valid with valid attributes' do
    expect(reservation_1).to be_valid
  end

  context '#validation' do
    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:code) }
  end
end
