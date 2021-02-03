class UsersController < ApplicationController

  def create
    idToken = params[:idToken]
    channelId = '1655592642'
    res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'),
                          {'id_token'=>idToken, 'client_id'=>channelId})
    render :json => res.body
    line_user_id = JSON.parse(res.body)["sub"]
    user = User.find_or_create_by(line_user_id: line_user_id)
  end

end
