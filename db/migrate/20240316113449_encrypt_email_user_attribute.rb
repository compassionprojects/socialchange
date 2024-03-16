class EncryptEmailUserAttribute < ActiveRecord::Migration[7.1]
  def up
    User.all.find_each { |u| u.encrypt.save }
  end

  def down
    User.all.find_each { |u| u.decrypt.save }
  end
end
