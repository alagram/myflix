class GenerateTokensForExistingUsers < ActiveRecord::Migration
  def up
    User.all.each do |user|
      user.update_column(:token, SecureRandom.urlsafe_base64)
    end
  end
end
