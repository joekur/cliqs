# encoding: utf-8

class ProfilePicUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def cache_dir
    "#{Rails.root.to_s}/tmp/uploads"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/assets/fallback/" + [version_name, "default_profile.jpg"].compact.join('_')
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [200, 400]
  process :convert => 'jpg'

  # Create different versions of your uploaded files:
  version :post do
    process :resize_to_fill => [90, 90]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png tif tiff bmp)
  end

  def filename
	  random_token = Digest::SHA2.hexdigest("#{Time.now.utc}--#{model.id.to_s}").first(30)
	  ivar = "@#{mounted_as}_secure_token"
	  token = model.instance_variable_get(ivar)
	  token ||= model.instance_variable_set(ivar, random_token)
	  "profpic_#{token}.jpg" if original_filename
  end

end
