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
    # binding.pry

    # if !params["owner"]["name"].empty?
    if !params["owner_name"].empty?
      # owner = Owner.create(name: params["owner"]["name"])
      owner = Owner.create(name: params["owner_name"])
      # @pet = Pet.create(name: params[:pet_name],owner_id: owner.id)
      @pet = Pet.create(name: params[:pet_name],owner_id: owner.id)
    else
      # @pet = Pet.create(name: params[:pet_name],owner_id: params[:owner_id])
      @pet = Pet.create(name: params[:pet_name],owner_id: params[:owner_id])
    end
    @pet.save
    redirect to "/pets/#{@pet.id}"
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

    # @owner = Owner.find(params[:id])
    # @owner.update(params["owner"])
    # if !params["pet"]["name"].empty?
    #   @owner.pets << Pet.create(name: params["pet"]["name"])
    # end

    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name],owner_id: params[:owner][:id])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
