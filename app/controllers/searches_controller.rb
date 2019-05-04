class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  # GET /searches
  # GET /searches.json
  def index
    console
    @api_key = ENV['OMDB_API_KEY']
    @searches = Search.all

    @title = ""
    @year = ""
    
    @movie = params["watchlist"]
    
    if @movie.present?
      @title = @movie["title"]
      @year = @movie["year"]
    end

    unless @title.ascii_only? then
      @title = @title.delete!("^\u{0000}-\u{007F}")
    end
    unless @year.ascii_only? then
      @year = @year.delete!("^\u{0000}-\u{007F}")
    end
    
    if @year.nil?
      @datas = HTTParty.get('http://www.omdbapi.com/?apikey='+@api_key+'&t='+@title)
    elsif @title.nil?
      @datas = HTTParty.get('http://www.omdbapi.com/?apikey='+@api_key+'&y='+@year)
    elsif @title.nil? & @year.nil?
      @title = "Avengers" # Sample Movie from DataBase
      @year = "2012"      # Sample Movie from DataBase
      @datas = HTTParty.get('http://www.omdbapi.com/?apikey='+@api_key+'&t='+@title+'&y='+@year)
    else
      @datas = HTTParty.get('http://www.omdbapi.com/?apikey='+@api_key+'&t='+@title+'&y='+@year)
    end
    
    #resp.body # => displays body of the response
    
    @parsed_json = JSON.parse(@datas.body) # => parses JSON if you need to parse it

  end

  # GET /searches/1
  # GET /searches/1.json
  def show
  end

  # GET /searches/new
  def new
    @search = Search.new
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:watchlist).permit(:title, :year)
    end
end
