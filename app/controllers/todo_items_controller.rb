class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      notify_subscribed_users
      redirect_to @todo_list, notice: 'Todo item added!'
    else
      redirect_to @todo_list, alert: 'Please some content in the new todo item'
    end
  end

  def destroy
    if @todo_item.destroy
      notify_subscribed_users
      flash[:notice] = "Todo item deleted!"
    else
      flash[:notice] = "Todo item could not be deleted."
    end
    redirect_to @todo_list
  end

  def complete
    if @todo_item.completed?
      @todo_item.update_attribute(:completed_at, nil)
      notify_subscribed_users
      redirect_to @todo_list, notice: "Todo item marked as incomplete!"
    else
      @todo_item.update_attribute(:completed_at, Time.now)
      notify_subscribed_users
      redirect_to @todo_list, notice: "Todo item marked as completed!"
    end
  end

  private

    def notify_subscribed_users
      @todo_list.users.each do |user|
        Notification.create(recipient: user, user: current_user,
          action: "updated", notifiable: @todo_list, todo_list_title: @todo_list.title)
      end
    end

    def set_todo_item
      @todo_item = @todo_list.todo_items.find(params[:id])
    end

    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    def todo_item_params
      params.require(:todo_item).permit(:content)
    end
end
