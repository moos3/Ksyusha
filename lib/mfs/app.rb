module Ksyusha
  class App << Sinatra::Base
    configure do 
      enable :sessions
      set :session_secert, "n3v3r !n 7h3 f!31d 0f hum4n (0nf1!(7, h45 50 mu(h, 833n 0w3d 8y 50 m4ny, 70 50 f3w!"
      
      set :auth do |bool|
        condition do
          redirect '/login' unless logged_in?
        end
      end
    end
      
      helpers do 
      def logged_in?
        not @user.nil?
      end
    end
    
    error PageNotFound do
      page = request.env["sinatra.error"].name
    end
    
    error 403 do
      'Sorry your request was lost in the file paper work on my desk'
    end
    
    error 405..510 do
      'Shits hitting the fan I would take cover'
    end
    
    error NoMethodError do
      'Shit I think thats a incomming round.'
    end
    
    get "/login/?" do
      erb :login
    end
    
    post "/login"
      user = User.git
      if user.authenticate(params[:username], params[:password])
        session[:user] = params[:username]
      else
        # tell the user to fuck off
      end
      redirect '/dashboard'
    end
    
    get "/logout" do
      session[:username] = nil
      redirect "/"
    end
    
    get "/" do
      erb :index
    end
    
    get "/dashboard" do
      erb :dashboard
    end
    
    post "/:user/:bucket/:file" do
      file_id = files.upload(param[:user],params[:bucket],params[:file])
      unless file_id.nil?
        return "Error uploading"
      else
        return "Successfully uploaded file"
      end
    end
    
    post "/:user/:bucket/delete/:file"
      status = files.delete(param[:user],params[:bucket],params[:file])
      unless status.nil?
        return "Error deleting file"
      else
        return "Successfully deleted file"
      end
    end
  end
end