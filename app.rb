require "sinatra"
require "active_record"
require "gschool_database_connection"
require "rack-flash"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get '/' do
    erb :root
  end

  get '/register' do
    erb :register
  end

  post "/registration" do
    username = params[:username]
    password = params[:password]
    if username == "" && password == ""
      flash[:registration_error] = "No username or password entered"
    elsif password == ""
      flash[:registration_error] = "No password entered"
    elsif username == ""
      flash[:registration_error] = "No username entered"
    else
      @database_connection.sql("insert into users (username, password) values ('#{username}', '#{password}')")
      flash[:notice] = "Thank you for registering"
      redirect '/'
    end
    redirect back
  end

  get '/database' do
    erb :database
  end

end
