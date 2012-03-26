if Rails.env.production?

  SECRETS = YAML.load_file("#{Rails.root}/config/secrets.yml")[Rails.env]

  ENV['AWS_ACCESS_KEY_ID'] = SECRETS['AWS_ACCESS_KEY_ID']
  ENV['AWS_SECRET_ACCESS_KEY'] = SECRETS['AWS_SECRET_ACCESS_KEY']

end