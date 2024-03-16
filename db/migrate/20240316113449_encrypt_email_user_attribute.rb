class EncryptEmailUserAttribute < ActiveRecord::Migration[7.1]
  def up
    User.all.find_each do |u|
      u.encrypt
      u.save
    end
  end

  def down
    User.all.find_each do |u|
      u.decrypt
      u.save
    end
  end
end
