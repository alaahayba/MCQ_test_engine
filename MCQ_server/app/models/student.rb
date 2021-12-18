class Student < ApplicationRecord
    has_many :StudentEnroll , dependent: :destroy

end
