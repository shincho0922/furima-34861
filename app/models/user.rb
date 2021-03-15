class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :nickname,        presence: true 
  validates :first_name,      presence: true, format: { with: /\A^[ぁ-んァ-ン一-龥]/ }
  validates :last_name,       presence: true, format: { with: /\A^[ぁ-んァ-ン一-龥]/ }
  validates :first_name_kana, presence: true, format: { with: /\A^([ァ-ン]|ー)+$\z/ }
  validates :last_name_kana,  presence: true, format: { with: /\A^([ァ-ン]|ー)+$\z/ }
  validates :date_of_birth,   presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 
end
