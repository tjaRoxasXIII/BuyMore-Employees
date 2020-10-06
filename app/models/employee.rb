class Employee < ActiveRecord::Base
    belongs_to :store
    has_many :updates
    has_secure_password

    def full_name
        @full_name = "#{self.first_name} #{self.last_name}"
    end
end