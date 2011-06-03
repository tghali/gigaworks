module Documents::DocumentsHelper

def calculate_document_size(doc)
  begin
	filesize = doc.document_file_size
	if Integer(filesize) >  1024
	(Integer(filesize) / 1024).to_s + " Mb"
	else
		filesize + " kb"
	end
    rescue
	  return "There is a problem to show file size."
    end
end


def calculate_wordcount(doc)
  begin
	data = open(doc.document.url(:original)).read
	word = (data.to_s).split(" ")
	return word.length
   rescue
	   return "There is a problem to show word count."
   end
end

end
