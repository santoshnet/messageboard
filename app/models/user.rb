class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :messages
         has_many :comments


         acts_as_reader

  
  def self.reader_scope
    where(:is_admin => true)
  end
end
