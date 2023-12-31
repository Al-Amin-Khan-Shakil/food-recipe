require 'rails_helper'
RSpec.describe User, type: :model do
  subject { User.new(name: 'Tony') }
  before { subject.save }
  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
