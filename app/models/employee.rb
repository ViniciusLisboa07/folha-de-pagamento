class Employee < ApplicationRecord
  has_many :payments, class_name: "payment"
end
