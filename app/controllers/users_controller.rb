class UsersController < ApplicationController
  respond_to :html, :json

  def index
    #@users = User.all.order(:created_at)
    @users = User.order(:created_at).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.friendly.find(params[:id])
    if @user == current_user
      @timestamp = Time.now.to_i
      @transformation = User.image_transformation
      @signature = User.generate_cloudinary_signature(@timestamp)
      @api_key = ENV['CLOUDINARY_KEY']
      gon.url = Cloudinary::Utils.cloudinary_api_url
      gon.user = @user
      render action: "edit"
    else
      respond_with @user
    end
  end

  def new
    @user = User.new
    if cookies[:location]
      c = JSON.parse cookies[:location]
      @user.build_location(c) if c.present?
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user, status: :created, location: @user }
    end
  end

  def edit
    @user = User.friendly.find(params[:id])
    @timestamp = Time.now.to_i
    @transformation = User.image_transformation
    @signature = User.generate_cloudinary_signature(@timestamp)
    @api_key = ENV['CLOUDINARY_KEY']
    gon.url = Cloudinary::Utils.cloudinary_api_url
    gon.user = @user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:error] = flatten_model_errors(@user.errors)
      render action: "new"
    end
  end

  def update
    @user = User.friendly.find(params[:id])
    image = @user.avatar_image_id if params[:user] and params[:user][:avatar_image_id]
    respond_to do |format|
      if @user.update_attributes(params[:user])
        Cloudinary::Uploader.destroy(image)
        format.html { redirect_to @user}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end
end
