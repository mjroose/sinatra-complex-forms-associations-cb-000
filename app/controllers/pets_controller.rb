class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all

    erb :'/pets/edit'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet])

    if !params["owner_name"].empty?
      @pet.owner_id = Owner.create(name: params["owner_name"]).id
      @pet.save
    elsif !params[:pet][:owner_id].empty?
      @owner = Owner.find(params[:pet][:owner_id])
      @pet.owner = @owner
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    binding.pry
    redirect to "pets/#{@pet.id}"
  end
end
