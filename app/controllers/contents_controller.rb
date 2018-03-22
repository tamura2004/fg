class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :set_zone
  before_action :authorize

  # GET /zones/:zone_id/contents
  # GET /zones/:zone_id/contents.json
  def index
    @contents = current_user.contents.where(zone_id: @zone.id)
  end

  # GET /zones/:zone_id/contents/1
  # GET /zones/:zone_id/contents/1.json
  def show
    send_data(@content.file, filename: @content.name, disposition: :attachment)
  end

  # GET /zones/:zone_id/contents/new
  def new
    @content = Content.new
  end

  # GET /zones/:zone_id/contents/1/edit
  def edit
  end

  # POST /zones/:zone_id/contents
  # POST /zones/:zone_id/contents.json
  def create
    file = content_params[:file]
    @content = Content.new(
      name: file.original_filename,
      file: file.read,
      user_id: current_user.id,
      zone_id: @zone.id
    )

    respond_to do |format|
      if @content.save
        format.html { redirect_to zone_contents_url(@zone), notice: 'ファイルを登録しました' }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zones/:zone_id/contents/1
  # PATCH/PUT /zones/:zone_id/contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to zone_contents_url(@zone), notice: 'ファイルを更新しました' }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zones/:zone_id/contents/1
  # DELETE /zones/:zone_id/contents/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to zone_contents_url(@zone), notice: 'ファイルを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    def set_zone
      @zone = Zone.find(params[:zone_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(:content).permit(:file)
    end

    def authorize
      unless current_user
        redirect_to :login
      end
    end
end
