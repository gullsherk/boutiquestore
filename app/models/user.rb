# == Schema Information
#
# Table name: users
#
#  id                   :bigint(8)        not null, primary key
#  first_name           :string
#  last_name            :string
#  email                :string
#  phone                :string
#  password             :string
#  authentication_token :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class User < ApplicationRecord

  # Constants
  PHONE_REGEX = /\A^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$\z/
  EMAIL_REGEX = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$\z/

  # Associations
  has_many :orders

  #Validations
  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 20 }
  validates :email, format: { :with => EMAIL_REGEX, :message => 'invalid email' }, allow_blank: false
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :phone, format: { :with => PHONE_REGEX, :message => 'invalid number' }, allow_blank: true, uniqueness: true

end
