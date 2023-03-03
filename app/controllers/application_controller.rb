class ApplicationController < ActionController::API


    def authenticate_session
        a = User.find_by(token: params[:token])
        if a.nil?
            render json: { error: "Not Authorized" }, status: 401
        elsif !a.logged_in
            render json: { error: "Please log in" }, status: 401
        elsif a.expire_at < Time.now
            render json: { error: "Session expired" }, status: 401
        end
    end
end
