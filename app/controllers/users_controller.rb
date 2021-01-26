class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    debugger
    idToken = params[:idToken]
    channelId = '1655592642'
    res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'),
                          {'id_token'=>idToken, 'client_id'=>channelId})
    render :json => res.body
    obj = JSON.parse(res.body);
    if nil == User.find_by(line_user_id: obj["sub"])
      @user = User.new(line_user_id: obj["sub"])
      @user.save
    end
  end

end
