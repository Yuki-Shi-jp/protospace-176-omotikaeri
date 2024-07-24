class PrototypesController < ApplicationController
  # ユーザーじゃない人がindex show以外にアクセスすると実行する関数
  before_action :move_to_index, except:[:index, :show]

  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create

     # new protで空白を入力するとその場所にとどまる
     @prototype = Prototype.create(prototype_params)
      if @prototype.save
       redirect_to root_path
     else
       render :new, status: :unprocessable_entity
     end

  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
     @prototype = Prototype.find(params[:id])
  end

  def update
    # 空白文字を入力するとその場所にとどまる

    @prototype = Prototype.find(params[:id])
    if  @prototype.update(prototype_params)
        redirect_to prototype_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  # 直接url入力するとリダイレクトで初期画面に飛ぶ
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
