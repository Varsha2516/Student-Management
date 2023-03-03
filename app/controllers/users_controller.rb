class UsersController < ApplicationController

    def create
        b = User.new(
          first_name: user[:first_name],
          last_name: user[:last_name],
          email: user[:email],
          password: user[:password],
          password_confirmation: user[:password_confirmation]
        )
        if params[:password] == params[:password_confirmation]
          if b.save
            render json: { message: "you have registered successfully" }, status: 201
          else
            render json: b.errors.details
          end
        else
          render json: { error: "Password and confirmation does not match" }
        end
    end


    def login
        c = User.find_by(email: params[:email])
        if c && c.password == params[:password]
          token = SecureRandom.hex(10)
          expire_at = Time.now + 2.hours

          c.update(token: token, expire_at: expire_at, logged_in:true)
          render json: { token: token, message: "you have logged in successfully" }, status: 200
        else
          render json: { error: 'Invalid email or password' }, status: 404
        end
    end


    def forgot_password
        a = User.find_by(email: params[:email])
        if a
          a.update(password_reset_token: SecureRandom.hex(10), password_reset_token_expire_at: Time.now + 2.hours)
          render json: { message: 'Password reset link has been sent to your email' }, status: 200
        else
          render json: { error: 'No user found with that email address' }, status: 404
        end
    end


    def reset_password
        a = User.find_by(password_reset_token: params[:password_reset_token])
        if a
          if a && a.password_reset_token_expire_at > Time.now
          a.update(password: params[:password])
            render json: { message: "Password has been reset successfully" }, status: 200
          else
            render json: { error: "expired token" }, status: 401
          end
        else
            render json: { error: "invalid token" }, status: 401
        end
    end



    def logout
        c = User.find_by(email: params[:email])
        if c
        c.update(logged_in: false)
          render json: { message: "Logged out successfully" }, status: 200
        else
          render json: { error: "Invalid email" }, status: 401
        end
    end


    def user
      params.require(:user).permit([
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation
      ])
    end   


end
