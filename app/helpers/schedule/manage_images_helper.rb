module Schedule::ManageImagesHelper

def get_width(image_id)
	 @uploadimage = ManageImage.find(image_id)  
	  geo = Paperclip::Geometry.from_file(@uploadimage.image.to_file(:thumb))
         return -(geo.width)/2
end
end
