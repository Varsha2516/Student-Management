class MarksController < ApplicationController

    before_action :authenticate_session
      

    def index
        a = Mark.all
        render json: a, status: 200
    end


    def create
        a = Mark.new(
            student_id: art[:student_id],
            tamil: art[:tamil],
            english: art[:english],
            maths: art[:maths],
            science: art[:science],
            social: art[:social],
            score: art[:score],
        )
        if a.save
            render json: a, status: 201
        else
            render json: a.errors.details
        end
    end

    
    def query
        a = Student.joins(:marks).where("first_name LIKE ?", "%#{params[:search]}%").select("students.id,students.first_name,students.last_name,marks.tamil,marks.english,marks.maths,marks.science,marks.social")
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


    def show
        a = Student.joins(:marks).where(id: params[:id]).select("students.id,students.first_name,students.last_name,marks.tamil,marks.english,marks.maths,marks.science,marks.social")
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
        a =  Mark.find_by(id: params[:id])
        if a
            a.update(tamil: params[:tamil], english: params[:english], maths: params[:maths], science: params[:science], social: params[:social])
            render json: { message: "updated" }, status: 200
        else
            render json: { error: "not found" }, status: 404
        end
    end


    def destroy
        a = Mark.find_by(id: params[:id])
        if a
            a.destroy
            render json: { message: "deleted" }, status: 200
        else
            render json: { error: "not found" }, status: 404
        end
    end


    
    

    private
    def art
        params.require(:mark).permit(:student_id, :score, :tamil, :english, :maths, :science, :social, :total)
    end
end
