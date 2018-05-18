class Oleg < ApplicationRecord
	include OlegsHelper
  belongs_to :user

	validate :right_answer
	
	private

  	#validates the right answer
  	def right_answer
  		if !(answer.downcase == $answer.downcase) && 
         !(answer.downcase == $word_answer.downcase)
  			errors.add(:answer, "")
  		end
  	end
#
end
