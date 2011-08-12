module Schedule::ScheduleHelper

def get_arabic_data(sentence_id)
	tpairs = TranslationPair.find(:all,:conditions => ["sentence_id = #{sentence_id} AND language_code = 1"])
	if !tpairs.blank?
		finalcode = ""
			    for pair in tpairs	
			      finalcode = tpairs.size > 1	? finalcode + pair.text + " / " : finalcode + pair.text 
			  end
		      return finalcode

	else
		return " "
	end
end

end
