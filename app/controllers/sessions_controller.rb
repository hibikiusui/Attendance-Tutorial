class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
      
    else
      # ここにはエラーメッセージ用のflashを入れます。
      flash.now[:danger] = "認証に失敗しました。"
      render :new
    end
  end
  
  
  def destroy
    # ログイン中の場合のみログアウト処理を実行します。
    log_out if loggen_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end


