class CommentsController < ApplicationController
   before_action :authenticate_user!
   before_action :find_message
   before_action :find_comment, only: [:edit, :update, :destroy]
  def create
    p params
   #@message = Message.find(params[:message_id])
   @comment = @message.comments.create(comment_params)
   @comment.user_id = current_user.id
     respond_to do |format|
      if @comment.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end

  end

 def edit
    
  # @comment = @message.comments.find(params[:id])
 end

 def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @message, notice: 'comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
 end

 def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to messages_path(@message), notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 def find_message
    @message = Message.find(params[:message_id])
 end
 def find_comment
     @comment = @message.comments.find(params[:id])
 end

  private

   def comment_params
     params.required(:comment).permit(:content)
   end

end
