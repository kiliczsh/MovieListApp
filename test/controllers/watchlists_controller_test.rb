require 'test_helper'

class WatchlistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @watchlist = watchlists(:one)
  end

  test "should get index" do
    get watchlists_url
    assert_response :success
  end

  test "should get new" do
    get new_watchlist_url
    assert_response :success
  end

  test "should create watchlist" do
    assert_difference('Watchlist.count') do
      post watchlists_url, params: { watchlist: { director: @watchlist.director, genre: @watchlist.genre, rating: @watchlist.rating, title: @watchlist.title, year: @watchlist.year } }
    end

    assert_redirected_to watchlist_url(Watchlist.last)
  end

  test "should show watchlist" do
    get watchlist_url(@watchlist)
    assert_response :success
  end

  test "should get edit" do
    get edit_watchlist_url(@watchlist)
    assert_response :success
  end

  test "should update watchlist" do
    patch watchlist_url(@watchlist), params: { watchlist: { director: @watchlist.director, genre: @watchlist.genre, rating: @watchlist.rating, title: @watchlist.title, year: @watchlist.year } }
    assert_redirected_to watchlist_url(@watchlist)
  end

  test "should destroy watchlist" do
    assert_difference('Watchlist.count', -1) do
      delete watchlist_url(@watchlist)
    end

    assert_redirected_to watchlists_url
  end
end
