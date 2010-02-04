class Application < Sinatra::Default
  enable :static,  :methodoverride, :reload
  set :environment, :development
  set :app_file, __FILE__

  # Warden configuration
  set :auth_login_template, 'application/index'
  set :auth_success_path, '/dashboard'
  set :back, '/dashboard'
  
  register Sinatra::Warden
  use Warden::Manager do |manager|
    manager.default_strategies :auth_db
    manager.strategies.add(:auth_db, Warden::Strategies::DataBase)
  end

  get '/stylesheets/base.css' do
    headers 'Content-Type' => 'text/css; charset=utf-8'
    sass :base
  end

  get '/' do
    myhaml :index
  end
  
  get '/dashboard' do
    myhaml :welcome
  end
end