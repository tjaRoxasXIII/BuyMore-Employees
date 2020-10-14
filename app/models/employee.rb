class Employee < ActiveRecord::Base
    belongs_to :store
    has_many :updates
    validates :email, uniqueness: :true
    validates :first_name, :last_name, :job_title, :birthdate, presence: :true
    has_secure_password

    def full_name
        @full_name = "#{self.first_name} #{self.last_name}"
    end
end