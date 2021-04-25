require 'rails_helper'

RSpec.describe 'productmodelのテスト', type: :model do
  describe 'def sell' do
    let(:order1) { FactoryBot.create(:order) }
    let(:product1) { FactoryBot.create(:product) }

    it 'buysell_flugが1の場合入札を返す' do
      expect(product_1.sell).to eq '1'
    end
  end
end
