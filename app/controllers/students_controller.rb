class StudentsController < ApplicationController

    before_action :authenticate_session
    
    def index
        a = Student.page(params[:page]).per(3)
        render json: a, status: 200
    end


    def create
        a = Student.new(
            first_name: art[:first_name],
            last_name: art[:last_name],
            email: art[:email],
            contact_number: art[:contact_number]
        )
        if a.save
            render json: a, status: 201
        else
            render json: a.errors.details
        end
    end


    def show
        a = Student.find_by(id: params[:id])
        if a
            render json: a, status: 200
        else
            render json: { message: "not found" }, status: 404
        end
     
    end

    def mark_list
        a = Student.joins(:marks).select("students.first_name,students.last_name,marks.tamil,marks.english,marks.maths,marks.science,marks.social")
        res = []
        a.each do |ab|
            o = {}
            o[:first_name] = ab.first_name
            o[:last_name] = ab.last_name
            o[:tamil] = ab.tamil
            o[:english] = ab.english
            o[:maths] = ab.maths
            o[:science] = ab.science
            o[:social] = ab.social
            o[:result] = ab.tamil + ab.english + ab.maths + ab.science + ab.social
            num = o[:result]
            case num
            when 0..150
                o[:grade] = "F"
            when 151..300
                o[:grade] = "B"
            when 301..450
                o[:grade] = "A"
            else
                o[:grade] = "A+"
            end
            res << o
        end
        render json: res, status: 200
    end


    def update
        a =  Student.find_by(id: params[:id])
        if a
            a.update(first_name: params[:first_name], last_name: params[:last_name], contact_number: params[:contact_number])
            render json: { message: "updated" }, status: 200
        else
            render json: { error: "not found" }, status: 404
        end
    end


    def destroy
        a = Student.find_by(id: params[:id])
        if a
            a.destroy
            render json: { message: "deleted" }, status: 200
        else
            render json: { error: "not found" }, status: 404
        end
    end
      

    private
    def art
        params.require(:student).permit([
            :first_name,
            :last_name,
            :email,
            :contact_number
        ])
    end

    
end



    


