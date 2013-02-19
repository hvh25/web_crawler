require 'will_paginate/array'

class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  def index
   # @jobs = Job.all

   @search = Job.search do
      keywords params[:query]
      paginate(:per_page => 20, :page => params[:page])
      facet(:jobtype)
    with(:jobtype, params[:jobtype]) if params[:jobtype].present?
    end
    @jobs = @search.results
 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  def get_all_links
    #@job = Job.find(params[:id])
    #@job.delay.get_all_links
      get_all_links
      puts 'Hello get_all_link_HAHAHA'
      redirect_to jobs_url, notice: "Success get all links"
    end


=begin
  def search 
    @jobs = Job.search do
      keywords params[:query]
    end.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end
=end
  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end

end

