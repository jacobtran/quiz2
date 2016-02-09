class SupportRequest < ActiveRecord::Base
  validates :name, presence: true,
                   length: {minimum: 3},
                   uniqueness: {case_sensitive: false,
                                message:        "already exists!"}

  validates :email,
               format: { with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }


  #  def self.search(term)
  #     where(["name ILIKE ? OR email ILIKE ? OR email ILIKE ?", "%#{term}", "%#{term}%"]).order("done DESC")
  #   end

  def self.search(search)
    where(["name ILIKE ? OR email ILIKE ? OR department ILIKE ? OR message ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"]).order("done")
  end

  def custom_event()
    p "inside custom event"
    p self
    return nil
    # self.update(:done => true)
    # p self.done
    # p "HELLO!!! from custom_event"
    # redirect_to support_request_path(@support_request)
  end
  # def self.done(done)
  #   # we need to feth the question first to update it
  #   self.update(:id, :user_name => 'Samuel', :group => 'expert')
  #
  #   #we call the update with sanitized params
  #   if @support_request.update support_request_params
  #   # we redirect to the question show page
  #     redirect_to support_request_path(@support_request)
  #   end
  # end
end
