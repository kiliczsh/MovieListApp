json.extract! watchlist, :id, :title, :year, :director, :genre, :rating, :created_at, :updated_at
json.url watchlist_url(watchlist, format: :json)
