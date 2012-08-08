module GameHelper
  def dequeue_messages
      message = @game.messages
      @game.clear_messages
      @game_result.save!
      return message
  end
end
