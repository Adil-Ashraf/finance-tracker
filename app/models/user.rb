class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def stock_already_tracked?(ticker_symbol)    # if the user is already tracking the stock
    stock = Stock.check_db(ticker_symbol)      # the check_db is returning an object 
    return false unless stock
    stocks.where(id: stock.id).exists?          # not calling it through user bcause we are already in user class
  end

  def under_stock_limit?
    #  here because w are in user class therefore we are not using User
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def fullname
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end
