class SessionsController < ApplicationController

    def create
        a = Session.create(
            token: SecureRandom.hex(10), 
            expire_at: Time.now + 2.minutes)
        render json: a
    end

    
end
