class DumpOleg < ApplicationRecord
	validate :right_answer
	
	private

  	#validates the right answer
  	def right_answer
  		if !(answer == $answer)
  			errors.add(:answer, "")
  		end
  	end
end
