class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    pet = Pet.create(params["pet"])
    if Owner.find_by(name: params["owner"]["name"]).nil?
      owner = Owner.create(params["owner"])
      pet.owner = owner
      pet.save
    end
    if !params["pet"]["owner_id"].nil?
      pet.owner = Owner.find(params["pet"]["owner_id"].to_i)
      pet.save
    end
    # if !params["owner"]
    #   owner = Owner.create(params["owner"])
    #   pet.owner = owner
    #   pet.save
    # end

    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    pet = Pet.find(params[:id])
    pet.name = params["pet"]["name"]
    # if !params["pet"]["owner_id"] !=
    #   pet.owner = Owner.find(params["pet"]["owner_id"].to_i)
    #   pet.save
    # end
    # if Owner.find_by(name: params["owner"]["name"]).nil?
    #   owner = Owner.create(params["owner"])
    #   pet.owner = owner
    #   pet.save
    # end

    if params["owner"]["name"].empty?
      pet.owner = Owner.find(params["pet"]["owner_id"])
    else
      pet.owner = Owner.create(name: params["owner"]["name"])
    end

    pet.save

    redirect "pets/#{pet.id}"

  end
end
