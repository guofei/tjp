CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage                          = :fog
    config.fog_credentials                  = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV["AWS_S3_KEY_ID"],
      :aws_secret_access_key => ENV["AWS_S3_SECRET_KEY"]
    }
    config.fog_directory                    = ENV["AWS_S3_BUCKET"]
    config.fog_public                       = false
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
  end
end
