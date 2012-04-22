# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end
  
  def cache_dir
    "#{Rails.root.to_s}/tmp/uploads"
  end
  
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :resize_to_fit => [600, 600]
  process :convert => 'jpg'

  # Create different versions of your uploaded files:
  version :wall do
    process :resize_to_fit => [380, 300]
  end
  version :square do
    process :resize_to_fill => [150, 150]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png tif tiff bmp)
  end
  
  
  #def filename
  #  if original_filename
  #    @name ||= "image_" + Digest::MD5.hexdigest(File.dirname(current_path))
  #    "#{@name}.jpg"
  #  end
  #end

  def filename
	  random_token = Digest::SHA2.hexdigest("#{Time.now.utc}--#{model.id.to_s}").first(30)
	  ivar = "@#{mounted_as}_secure_token"
	  token = model.instance_variable_get(ivar)
	  token ||= model.instance_variable_set(ivar, random_token)
	  "image_#{token}.jpg" if original_filename
  end
  

end
