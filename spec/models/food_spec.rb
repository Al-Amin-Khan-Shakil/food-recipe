require 'rails_helper'
RSpec.describe Food, type: :model do
  @user = User.create(name: 'Amos')
  subject { Food.new(name: 'onions', quantity: 3, price: 1, measurement_unit: 'kg', user_id: @user) }
  before { subject.save }
  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'price  should be a integer' do
    subject.price = 'not an integer'
    expect(subject).to_not be_valid
  end
  it 'quantity should be greater than or equal to 0' do
    subject.quantity = -3
    expect(subject).to_not be_valid
  end
  it 'quantity  should be a integer' do
    subject.quantity = 'not an integer'
    expect(subject).to_not be_valid
  end
  it 'price  should be greater than 0' do
    subject.price = 0
    expect(subject).to_not be_valid
  end
end
