class JobappsController < ApplicationController
  load_and_authorize_resource :job
  load_and_authorize_resource :jobapp, :through => :job, :shallow => true
  
  def index
    @jobapps = @job.jobapps
    @messageable = @job
    @messages = @messageable.messages
    @message = Message.new
  end

  def show
   # @jobapp = Jobapp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jobapp }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    #@job = Job.find(params[:job_id])
    @jobapps = @job.jobapps
    @jobapp = @jobapps.new
    #@jobapp.user = current_user
    #@user = current_user
    #@jobapp.user.update_attributes(params[:user])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jobapp }
    end
  end

  def create
    @jobapp = @job.jobapps.new(params[:jobapp])
    @owner = @job.user
    if current_user != nil
      @jobapp.user = current_user
      @user = current_user
    end

    if @jobapp.save
      #@user.update_attributes(params[:user])
      UserMailer.newapp_notice(@owner,@job,@jobapp).deliver  
      redirect_to [@job], notice: "Successfully submitted application."
    else
      render :new
    end
  end

    # GET /jobapps/1/edit
  def edit
    #@jobapp = Jobapp.find(params[:id])
  end

  # PUT /jobapps/1
  # PUT /jobapps/1.json
  def update
    #@jobapp = Jobapp.find(params[:id])

    respond_to do |format|
      if @jobapp.update_attributes(params[:jobapp])
        format.html { redirect_to @jobapp, notice: 'Jobapp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jobapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobapps/1
  # DELETE /jobapps/1.json
  def destroy
    #@jobapp = Jobapp.find(params[:id])
    @jobapp.destroy

    respond_to do |format|
      format.html { redirect_to jobapps_url }
      format.json { head :no_content }
    end
  end

end


