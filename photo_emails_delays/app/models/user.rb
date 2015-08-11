class User < ActiveRecord::Base

  has_attached_file :avatar, :styles => {:medium => "300x300", :thumb => "100x100"}
  validates_attachment_content_type :avatar ,
                                   :content_type => /\Aimage\/.*\Z/

  # after_create :send_welcome_email
  after_create :send_delayed_welcome_email

  # def self.send_welcome_email(id)
  #   user = User.find(id)
  #   UserMailer.welcome(user).deliver!
  # end

  def send_delayed_welcome_email
    UserMailer.delay.welcome(self.id)
  end
end
