module Documents::DocumentsHelper

def calculate_document_size(doc)
	filesize = doc.document_file_size
	if Integer(filesize) >  1024
	(Integer(filesize) / 1024).to_s + " Mb"
	else
		filesize + " kb"
	end
end


end
