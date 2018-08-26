class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = current_user.conversations
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @message = Message.new
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    # Try to find a matching conversation
    @conversation = current_user.conversation_with params[:conversation][:user_2_id]
    conversation_exists = !!@conversation

    # create new conversation if needed
    @conversation ||= Conversation.create conversation_params

    respond_to do |format|
      if @conversation.persisted?
        format.html do
          @message = Message.new
          render :show,
            status: conversation_exists ? :ok : :created,
            location: @conversation
        end
        format.json do
          render :show,
            status: conversation_exists ? :ok : :created,
            location: @conversation
        end
      else
        format.html { redirect_to '/users' }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit([:user_1_id, :user_2_id])
    end
end
