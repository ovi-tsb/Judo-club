class Post < ApplicationRecord
  belongs_to :user, optional: true
  validates_presence_of :title, :postimage, :details

  mount_uploader :postimage, PostImageUploader
end
