class SupportRequestsController < ApplicationController
  def new
    @support_request = SupportRequest.new
  end

  def create
    if params[:done]
      p "Hello inside done create"
    end

    support_request_params = params.require(:support_request).permit([:name, :email])
    @support_request = SupportRequest.new support_request_params
    if @support_request.save
      render text: "SUCCESS"
    else
      render :new
    end
    # render text: params
  end

  def show

    p "inside show"
    p params
    @support_request = SupportRequest.find params[:id]
  end

  # def index
  #   # @support_requests = SupportRequest.all
  #   @support_requests = SupportRequest.order(:done)
  # end
  def index
    @support_requests = SupportRequest.all
    # p "params[:search]"
    # p params[:search]
    # p "params[:done]"
    # p params[:done]
    p "params"
    p params
    if params[:search]
      @support_requests = SupportRequest.search(params[:search]).page(params[:page]).per(7)
    # elsif params[:done]
    #   # SupportRequest.update(:done => true)
    #   @support_requests = SupportRequest.search(params[:search])
    #   # @support_requests = SupportRequest.done(params[:done])
    else
      @support_requests = SupportRequest.order(:done).page(params[:page]).per(7)
    end
  end

  def edit
    p "inside edit"
    p params
    # we need to find the question that will be edited
    @support_request = SupportRequest.find params[:id]
  end

  def update
    p "inside update"
    p params.length
    # we need to feth the question first to update it
    @support_request = SupportRequest.find params[:id]
    p "@support_request.done"
    p @support_request.done

    if params.length == 5
      if @support_request.done
        support_request_params = {:done => false}
      else
        support_request_params = {:done => true}
      end

      @support_request.update support_request_params
      redirect_to root_path()

    else
      support_request_params = params.require(:support_request).permit([:name, :email])
      #we call the update with sanitized params
      if @support_request.update support_request_params
      # we redirect to the question show page
        redirect_to support_request_path(@support_request)
      else
        render :edit
      end
    end
  end

  def destroy
    @support_request = SupportRequest.find params[:id]
    @support_request.destroy
    # can use delete but will skip callbacks
    # we redirect to the index page
    redirect_to support_requests_path
  end

  def post
    p "HELLO!!! inside post"
  end
end
