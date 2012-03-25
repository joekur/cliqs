class AddEmailSettingsToCliqMemberships < ActiveRecord::Migration
  def change
    add_column :cliq_memberships, :get_post_email, :boolean, default: true

    add_column :cliq_memberships, :get_photo_email, :boolean, default: true

    add_column :cliq_memberships, :get_comment_email, :boolean, default: true

  end
end
