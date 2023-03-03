class Student < ApplicationRecord
    has_many :marks

    validates :last_name, presence: true
    validates :email, uniqueness: true
    validates :contact_number, length: { minimum: 3, maximum: 10}
    validates :first_name, presence: true
end