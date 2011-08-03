module Schedule::ScheduleHelper

def get_arabic_data(sentence_id)
	tpair = TranslationPair.find(:first,:conditions => ["sentence_id = #{sentence_id} AND language_code = 1"])
	if tpair
	     return tpair.text
	else
		return "None"
	end
end

end
