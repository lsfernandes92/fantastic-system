class TodoListsController < ApplicationController
  before_action :set_todo_list, except: [:index, :new, :create]

  def index
    @personal_lists = TodoList.where(user_id: current_user)
    @public_lists_from_users = TodoList.where.not(user_id: current_user, public: false).sample(2)
    @favorites_lists = current_user.favorite_todo_lists
  end

  def new
    @todo_list = current_user.todo_lists.build
  end

  def create
    @todo_list = current_user.todo_lists.build(todo_list_params)

    if @todo_list.save
      redirect_to todo_lists_url, notice: 'New Todo list was successfully created.'
    else
      render :new
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list, notice: 'Todo list was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_url, notice: 'Todo list was deleted.'
  end

  def change_visibility
    if @todo_list.public?
      @todo_list.update_attribute(:public, false)
      redirect_to @todo_list, notice: "Todo list marked as private"
    else
      @todo_list.update_attribute(:public, true)
      redirect_to @todo_list, notice: "Todo list marked as public"
    end
  end

  def add_favorite
    @favorite = current_user.favorites.build(todo_list_id: params[:id])

    if @favorite.save
      redirect_to @todo_list, notice: 'Todo list marked as favorite'
    else
      redirect_to @todo_list, alert: 'Todo list already marked as favorite'
    end
  end

  private
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    def todo_list_params
      params.require(:todo_list).permit(:id, :title, :description, :public)
    end
end
