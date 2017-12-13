require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_inclusion_of(:state).in_array(%w(pending delivered)) }
  it { is_expected.to validate_numericality_of(:price) }

  describe 'filtering by state' do
    let!(:first) { FactoryBot.create(:order, :pending) }
    let!(:second) { FactoryBot.create(:order, :delivered) }
    let!(:third) { FactoryBot.create(:order, :pending) }
    let!(:fourth) { FactoryBot.create(:order, :delivered) }
    let!(:fifth) { FactoryBot.create(:order, :pending) }

    context 'when state is pending' do
      it 'returns pending orders only' do
        expect(Order.by_state('pending')).to eq([first, third, fifth])
      end
    end

    context 'when state is delivered' do
      it 'returns delivered orders only' do
        expect(Order.by_state('delivered')).to eq([second, fourth])
      end
    end

    context 'when state is nil' do
      it 'returns all orders' do
        expect(Order.by_state(nil)).to eq([first, second, third, fourth, fifth])
      end
    end
  end
end
