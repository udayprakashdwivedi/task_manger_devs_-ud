class TasksController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_task, only: %i[show update destroy]

  def index
    pagy, tasks = pagy(current_user.tasks, items: 1)
    render json: { tasks: tasks, pagy: pagy }, each_serializer: TaskSerializer
  end

  def show
    render json: @task, serializer: TaskSerializer
  end

  def create
    task = current_user.tasks.build(task_params)
    if task.save
      render json: task, serializer: TaskSerializer, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task, serializer: TaskSerializer
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    render json: { error: "Task not found" }, status: :not_found unless @task
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date)
  end
end
