class Helpers

    def self.current_employee(session)
        @employee = Employee.find(session[:id])
    end
    
    def self.is_logged_in?(session)
        !!session[:id]
    end

end