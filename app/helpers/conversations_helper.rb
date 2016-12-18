module ConversationsHelper
  def other_user(conversation)
    (current_user.id == conversation.user_1.id) ? conversation.user_2 : conversation.user_1
  end
end
