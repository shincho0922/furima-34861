class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname         
    with_options format: { with: /\A^[ぁ-んァ-ン一-龥々]/ } do
      validates :first_name
      validates :last_name
    end
    with_options format: { with: /\A^([ァ-ン]|ー)+$\z/ } do
      validates :first_name_kana
      validates :last_name_kana
    end
    validates :date_of_birth
  end
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 

  has_many :items
end
