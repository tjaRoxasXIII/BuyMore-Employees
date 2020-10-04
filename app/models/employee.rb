class Employee < ActiveRecord::Base
    belongs_to :store
    has_many :updates
    has_secure_password
end