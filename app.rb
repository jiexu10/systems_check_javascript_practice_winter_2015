require "sinatra"
require "pg"

configure :development do
  set :db_config, { dbname: "questions_development" }
end

configure :test do
  set :db_config, { dbname: "dreams_test" }
end

def db_connection
  begin
    connection = PG.connect(Sinatra::Application.db_config)
    yield(connection)
  ensure
    connection.close
  end
end

def all_dreams
  all = nil
  db_connection do |conn|
    all = conn.exec("SELECT description FROM dreams")
  end
  all
end

def create_dream(description)
  db_connection do |conn|
    sql_query = "INSERT INTO dreams (description) VALUES ($1)"
    conn.exec_params(sql_query, [description])
  end
end

get "/" do
  redirect "/dreams"
end

get "/dreams" do
  @dreams = all_dreams
  erb :index
end

post "/dreams" do
  description = params[:description]
  create_dream(description) unless description.strip.empty?
  redirect "/dreams"
end

post "/dreams.json" do
  description = params[:description]
  if description
    create_dream(description)
  end
end
