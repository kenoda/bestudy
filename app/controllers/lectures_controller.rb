class LecturesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # sign_inのときに、group_keyも許可する
    devise_parameter_sanitizer.for(:sign_in) << :group_key
    # sign_upのときに、group_keyも許可する
    devise_parameter_sanitizer.for(:sign_up) << :group_key
    #account_updateのときに、group_keyも許可する
    devise_parameter_sanitizer.for(:account_update) << :group_key
  end


  def index
    @lectures = Lecture.order('id ASC') #最新順に教室を並べる
  end

  def new
    @lecture = Lecture.new
  end

  def create
    # Lecture.create(name: params[:name], season: params[:season], description: params[:description])
    Lecture.create(create_params)
#     lecture1 =Bfilter.new
#     doc ="真面目に勉強している"
# lecture1.train(doc, "A")
# lecture1.classifier("すごいよ") => B

  end

  def show
    @lecture = Lecture.find(params[:id])
    @student = Student.all
    # @student = Student.all ここで多対多の関係を使う必要がある
  end

  # private
  # def lecture_params
  #   params.permit(:name, :season, :description)
  # end

  private
  def create_params
    params.require(:lecture).permit(:name, :description, :season).merge(user_id: params[:user_id])
  end

end
