class PostsController < ApplicationController
  before_action :set_target_post, only: %i[show edit update destroy]

  def index
    # 投稿データを全て取得、またインスタンス変数なのでViewで参照可能
    @posts = Post.all
  end

  def new
    # Postモデルのオブジェクトを作成
    # @boardはインスタンス変数で、Viewで参照可能
    @post = Post.new
  end

  def create
    # データはparamsという変数に渡されてくる
    # create は、Postモデルのクラスメソッド
    Post.create(post_params)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  #追加
  def update
    post = Post.find(params[:id])
    # モデルの更新は、クラスメソッドのupdateメソッドで行える
    post.update(post_params)

    # リダイレクト処理
    redirect_to post
  end

  def destroy
    post = Post.find(params[:id])
    post.delete

    # 投稿一覧へリダイレクト
    redirect_to posts_path
  end

  private

  # paramsから欲しいデータのみ抽出
  def post_params
    params.require(:post).permit(:name, :title, :content)
  end
end
