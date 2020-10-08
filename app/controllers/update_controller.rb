class UpdateController < ApplicationController

    post '/updates/new' do
        @update = Update.new(content: params[:content])
        @update.employee_id = session[:id]
        @update.save
        redirect "/home"
    end
    
    get '/updates/:id/edit' do
        if Helpers.is_logged_in?(session)
            @update = Update.find_by(id: params[:id])
            if @update.employee_id == session[:id]
                erb :"/updates/edit"
            else
                redirect '/home'
            end
        else
            redirect '/home'
        end
        
    end
    
    patch '/updates/:id' do
        @update = Update.find_by(id: params[:id])
        @update.content = params[:content]
        @update.save
        redirect '/home'
    end
    
    get '/updates/:id/delete' do
        @update = Update.find_by(id: params[:id])
        if Helpers.is_logged_in?(session) && @update.employee_id == session[:id]
            @update.delete
            redirect '/home'
        else
            redirect '/'
        end
    end
    
end