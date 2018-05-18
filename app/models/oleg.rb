class Oleg < ApplicationRecord
	include OlegsHelper
  belongs_to :user

	validate :right_answer
	
	private

  	#validates the right answer
  	def right_answer
  		if !(answer == $answer) && !(answer == $word_answer)
  			errors.add(:answer, "")
  		end
  	end
#
end
