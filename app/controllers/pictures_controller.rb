class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def home
    @picture = Picture.where("created_at >= ?", Time.zone.now.beginning_of_day).first
  end

  def show
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def create
    @picture = Picture.new(picture_params)
    respond_to do |format|
      if @picture.save
        @picture.update_attributes(:score => 1)
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
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
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def score
    @picture = Picture.find(params[:id])
    @picture.update_attributes(:score => @picture.score + 1)
    redirect_to pictures_path
  end

  def search
    s = params[:s]
    low = Random.new.rand(0..100)
    results = GoogleCustomSearchApi.search("capybara", {"searchType" => "image", "num" => "10", "imgSize" => "large", "LowRange" => low, "highRange" => low + 9, "hq" => s})
    r = Random.new.rand(0..9)
    @picture = results.items[r].image.thumbnailLink
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:image, :score)
    end
end
