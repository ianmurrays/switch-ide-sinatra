require 'models/project'

module Api
  module V1
    class App < Sinatra::Base
      before(/^\/projects*/) { authenticate! }

      # Returns a list of projects on the DB
      get '/projects' do
        @user.projects.all.to_json
      end

      # Returns the JSON respresentation of a single project
      get '/projects/:id' do
        project = @user.projects.find(params[:id])
        
        halt 404 unless project

        project.to_json
      end

      post '/projects' do
        Project.create(:name => params[:name], :user => @user).to_json
      end

      delete '/projects/:id' do
        halt 404 unless project = @user.projects.find(params[:id])

        project.destroy

        halt 200
      end

      post '/projects/:id/build' do
        @user.projects.find(params[:id]).build_project.to_json
      end

      post '/projects/:id/run' do
        @user.projects.find(params[:id]).run_project.to_json
      end
    end
  end
end