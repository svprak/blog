class User < ActiveRecord::Base
  has_many :articles
  before_save {self.email = email.downcase}
  #validation
  validates :username, presence:true,
            uniqueness: {case_sensitive: false},
            length: {minimum:3, maximum: 15}
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i #/\A[+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length:{maximum: 75},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX}
  has_secure_password
end