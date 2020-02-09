class Member < ApplicationRecord
  enum status: {  inactive: 0, 
                    active: 1
                  }
  belongs_to :user, optional: true
end
