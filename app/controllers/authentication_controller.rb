class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login
    before_action :set_user,only: :login
    
    #En el Header key = Authorization y value = el token generado (copiar y pegar)
    
    # POST /auth/login
    def login
      @user = User.find_by_us(params[:u])
      if @user && @user.authenticate(params[:p])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 30.minutes.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       username: @user.us }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def login_params
      params.permit(:u, :p)
    end

    def set_user
        @user = User.find_by(us: params[:u])
    end
  end
