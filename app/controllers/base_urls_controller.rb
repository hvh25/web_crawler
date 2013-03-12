class BaseUrlsController < ApplicationController
  # GET /base_urls
  # GET /base_urls.json
  load_and_authorize_resource

  def index
    @base_urls = BaseUrl.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @base_urls }
    end
  end

  # GET /base_urls/1
  # GET /base_urls/1.json
  def show
    @base_url = BaseUrl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @base_url }
    end
  end

  # GET /base_urls/new
  # GET /base_urls/new.json
  def new
    @base_url = BaseUrl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @base_url }
    end

  end

  # GET /base_urls/1/edit
  def edit
    @base_url = BaseUrl.find(params[:id])
  end

  # POST /base_urls
  # POST /base_urls.json
  def create
    @base_url = BaseUrl.new(params[:base_url])

    respond_to do |format|
      if @base_url.save
        format.html { redirect_to @base_url, notice: 'Base url was successfully created.' }
        format.json { render json: @base_url, status: :created, location: @base_url }      
      else
        format.html { render action: "new" }
        format.json { render json: @base_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /base_urls/1
  # PUT /base_urls/1.json
  def update
    @base_url = BaseUrl.find(params[:id])

    respond_to do |format|
      if @base_url.update_attributes(params[:base_url])
        format.html { redirect_to @base_url, notice: 'Base url was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @base_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /base_urls/1
  # DELETE /base_urls/1.json
  def destroy
    @base_url = BaseUrl.find(params[:id])
    @base_url.destroy

    respond_to do |format|
      format.html { redirect_to base_urls_url }
      format.json { head :no_content }
    end
  end
end
