class Payment < ApplicationRecord
  belongs_to :employee, foreign_key: :employees_id
end
