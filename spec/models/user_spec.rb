require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができる時' do
      it '必要な情報が記載されていれば新規登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録ができない時'  do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'kazugmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = "abc45"
        @user.password_confirmation = "abc45"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      it 'パスワードは、数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password には英字と数字の両方を含めて設定してください"
      end
      it 'パスワードは、英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password には英字と数字の両方を含めて設定してください"
      end
      it 'パスワードは、全角文字では登録できない' do
        @user.password = 'ABC１２３'
        @user.password_confirmation = 'ABC１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password には英字と数字の両方を含めて設定してください"
      end
      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc567'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "ユーザー本名は、名字が必須であること" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it "ユーザー本名は、名前が必須であること" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it "ユーザー本名の名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
        @user.first_name = "kato"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name is invalid"
      end
      it "ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
        @user.last_name = "kazumaru"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name is invalid"
      end
      it "ユーザー本名の名字のフリガナは、入力が必須であること" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it "ユーザー本名の名前のフリガナは、入力が必須であること" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it "ユーザー本名の名字のフリガナは、全角（カタカナ）での入力が必須であること" do
        @user.first_name_kana = "かとう"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana is invalid"
      end
      it "ユーザー本名の名前のフリガナは、全角（カタカナ）での入力が必須であること" do
        @user.last_name_kana = "かずまる"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid"
      end
      it "生年月日が必須であること" do
        @user.date_of_birth = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Date of birth can't be blank"
      end
    end
  end
end
