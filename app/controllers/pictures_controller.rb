class PicturesController < ApplicationController
  before_action :set_picture, only: %i[show edit update destroy ]
  before_action :only_login_user, only: %i[index show okiniiri new edit confirm destroy]

  def index
    @pictures = Picture.all
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def okiniiri
    @favorite = current_user.favorites
    @picture = Picture.all
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def edit
  end

  def confirm
    # @picture = Picture.new(picture_params)
    @picture = current_user.pictures.build(picture_params)
  end

  def create
    # @picture = Picture.new(picture_params)
    @picture = current_user.pictures.build(picture_params)

    # respond_to do |format|
    #   if @picture.save
    #     PictureMailer.picture_mail(@picture).deliver
    #     format.html { redirect_to @picture, notice: '記事を投稿しました、確認用メールを送りました' }
    #     format.json { render :show, status: :created, location: @picture }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @picture.errors, status: :unprocessable_entity }
    #   end
    # end
    if @picture.save
      redirect_to pictures_url
    else
      render 'new'
    end
  end


  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: '記事を編集しました' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: '記事を削除しました' }
      format.json { head :no_content }
    end
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end

  def only_login_user
    if logged_in?
    else
      redirect_to  new_session_path, notice: 'ログインしてください'
    end
  end
end
