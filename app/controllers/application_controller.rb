class ApplicationController < Sinatra::Base

  #Set content type header for all responses'
  set :default_content_type, 'application/json'
    

  get '/games' do
    #get all the gamws from the database
    games = Game.all.order(:title).limit(10)

    #return a JSON response with an array of all the game data
    games.to_json

  end

  #Use :id to get a dynamic route

  get '/games/:id' do
    #Look up the game in the database using its ID
    game = Game.find(params[:id])
    #Send a JSON formatted response of the game data & include associated date in the response

    #game.to_json(include: { reviews: { include: :user}})

    #We can be more selective on the attributes returned from each model with only option

    game.to_json(only: [:id, :title, :genre, :price], include: { 
      reviews: { only: [:comment, :score], include: {
         user: {only: [:name]}
         }}
        })
  end

end