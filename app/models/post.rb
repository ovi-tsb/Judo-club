class Post < ApplicationRecord
  belongs_to :user, optional: true
  validates_presence_of :title, :details

  mount_uploader :postimage, PostImageUploader
end
