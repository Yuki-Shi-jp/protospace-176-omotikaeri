class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :destroy, :edit]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy] # アクション前にset_prototypeを呼び出している
  before_action :move_to_index, only: :edit
  # ユーザーじゃない人がindex show以外にアクセスすると実行する関数
  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    Prototype.create(prototype_params)
    # new protで空白を入力するとその場所にとどまる
    #  if @prototype.save
    # redirect_to root_path
    # else
    # render :new, status: :unprocessable_entity
    # end
    redirect_to '/'
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
    prototype = Prototype.find(params[:id])
    # prototype.update(prototype_params)
    if prototype.update(prototype_params)
      redirect_to root_path
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

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  # 直接url入力するとリダイレクトで初期画面に飛ぶ
  def move_to_index
    return if current_user == @prototype.user

    redirect_to user_session_path
  end
end
