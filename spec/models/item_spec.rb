require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '商品出品出来る時' do
      it '必要な情報が入力されていれば商品が出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品出来ない時' do
      it '商品画像を1枚つけることが必須である' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください") 
      end
      it '商品名が必須である' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品の説明が必須である' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品説明を入力してください")
      end
      it 'カテゴリーの情報が必須である' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it 'category_idが1では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは1以外の値にしてください")
      end
      it '商品の状態についての情報が必須である' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it 'status_idが1では保存できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は1以外の値にしてください")
      end
      it '配送料の負担についての情報が必須である' do
        @item.delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it 'delivery_fee_idが1では保存できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は1以外の値にしてください")
      end
      it '発送元の地域についての情報が必須である' do
        @item.delivery_source_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it 'delivery_source_idが1では保存できない' do
        @item.delivery_source_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は1以外の値にしてください")
      end
      it '発送までの日数についての情報が必須である' do
        @item.delivery_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end
      it 'delivery_date_idが1では保存できない' do
        @item.delivery_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は1以外の値にしてください")
      end
      it '販売価格についての情報が必須である' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("値段を入力してください")
      end
      it '販売価格は、¥300~保存可能である' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は299より大きい値にしてください")
      end
      it '販売価格は、~¥9,999,999まで保存可能である' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は10000000より小さい値にしてください")
      end
      it '販売価格は、半角数字のみ保存可能である' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は数値で入力してください")
      end
      it '販売価格は、半角英数字混合では保存できない' do
        @item.price = 'abc123'
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は数値で入力してください")
      end
      it '販売価格は、半角英字では保存できない' do
        @item.price = 'abcdef'
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は数値で入力してください")
      end

    end
  end
end
