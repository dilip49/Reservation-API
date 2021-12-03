require 'rails_helper'

describe Guest do
  let(:guest_1) { FactoryBot.create(:guest, email: 'test.hometime@booking.com') }

  it 'is valid with valid attributes' do
    expect(guest_1).to be_valid
  end

  context '#validation' do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
  end
end
