class LecturesController < ApplicationController
  def index
    @lectures = Lecture.order('id ASC') #最新順に教室を並べる
  end

  def new
    @lecture = Lecture.new
  end

  def create
    Lecture.create(name: params[:name], season: params[:season], description: params[:description])
#     Lecture.create(create_params)
#     lecture1 =Bfilter.new
#     doc ="真面目に勉強している"
# lecture1.train(doc, "A")
# lecture1.classifier("すごいよ") => B

  end

  def show
    @lecture = Lecture.find(params[:id])
    @student = Student.find(params[:id])
    # @student = Student.all ここで多対多の関係を使う必要がある
  end

  # private
  # def lecture_params
  #   params.permit(:name, :season, :description)
  # end

  private
  def create_params
    params.require(:lecture).permit(:name, :description, :season)
  end

end
