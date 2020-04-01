class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friends

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  validates_presence_of :last_name

  enum role: [:default, :admin]
  has_secure_password


  def bookmarks
    videos = Video.joins(:user_videos).where("user_videos.user_id = #{self.id}").order(:tutorial_id).order(:position)

    videos.inject(Hash.new([])) do |bookmarks, video|
      (bookmarks[video.tutorial_id] = []).push(video)
      bookmarks
    end
  end
end
