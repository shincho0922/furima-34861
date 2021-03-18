require 'rails_helper'

RSpec.describe Buy, type: :model do
  describe '商品の購入' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @buy = FactoryBot.build(:buy, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '新規登録ができる時' do
      it '必要な情報が記載されていれば商品が購入できる' do
        expect(@buy).to be_valid
      end
    end

    context '新規登録ができない時' do
      it '配送先の郵便番号が必須である' do
        @buy.post_code = ""
        @buy.valid?
        expect(@buy.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号の保存にはハイフンが必要である' do
        @buy.post_code = "1234567"
        @buy.valid?
        expect(@buy.errors.full_messages).to include("Post code is invalid")
      end
      it '配送先の都道府県が必須である' do
        @buy.prefecturse_id = ""
        @buy.valid?
        expect(@buy.errors.full_messages).to include("Prefecturse can't be blank")
      end
      it 'category_idが1では保存できない' do
        @buy.prefecturse_id = 1
        @buy.valid?
        expect(@buy.errors.full_messages).to include("Prefecturse must be other than 1")
      end
      it '配送先の市区町村が必須である' do
        @buy.municipality = ""
        @buy.valid?
        expect(@buy.errors.full_messages).to include("Municipality can't be blank")
      end
      it '配送先の番地が必須である' do
        @buy.address = ""
        @buy.valid?
        expect(@buy.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号は9桁以内の整数は保存できない' do
        @buy.phone_number = "123456789"
        @buy.valid?
        expect(@buy.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は英数字混合は保存できない' do
        @buy.phone_number = "080abcd1234"
        @buy.valid?
        expect(@buy.errors.full_messages).to include("Phone number is invalid")
      end

    end
  end
end
