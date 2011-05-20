module Images::ManageImagesHelper

def calc_file_size(image)
	filesize = image.image_file_size
	if Integer(filesize) >  1024
	(Integer(filesize) / 1024).to_s + " Mb"
	else
		filesize + " kb"
	end
end

end
