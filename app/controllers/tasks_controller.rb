class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_require

  # PER = 5
  # GET /tasks or /tasks.json
  def index

    @tasks = current_user.tasks
    @tasks = @tasks.order(deadline: :desc) if params[:sort_expired]
    @tasks = @tasks.order(priority: :asc) if params[:sort_priority_high]

    if params[:search].present?
      @tasks = @tasks.title_search(params[:search][:title]) if params[:search][:title].present?
      @tasks = @tasks.status_search(params[:search][:status]) if params[:search][:status].present?
    end

    @tasks = @tasks.page(params[:page]).per(5)
  end

    # #if params[:search].present?
    #   #binding.pry
    #   #if params[:search][:title].present? && params[:search][:status].present?
    #     #両方title and statusが成り立つ検索結果を返す
    #     #@tasks = @tasks.title_search(params[:search][:title])
    #     @tasks = @tasks.status_search(params[:search][:status])
        
    #     #渡されたパラメータがtask titleのみだったとき
    #   elsif params[:search][:title].present?
    #     @tasks = @tasks.title_search(params[:search][:title])
      
    #    #渡されたパラメータがステータスのみだったとき
    #   elsif params[:search][:status].present?
    #     @tasks = @tasks.status_search(params[:search][:status])
       
    #     #推しただけ
    #   #elsif params[:title].present=nil && params[:status].present=nil
    #    # @tasks = @tasks.order(created_at: :desc).page(params[:page]).per(PER)
    #   end
    # end
    #end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.new(task_params)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "タスクが登録されました。" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "タスクが更新されました。" }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "タスクが削除されました。" }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def login_require
    redirect_to new_session_path unless current_user
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :content, :status, :priority, :deadline)
  end
end
