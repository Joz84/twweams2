class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :channels, through: :subscriptions
  has_many :users, through: :channels

  validates :alias, presence: true
  validates :alias, uniqueness: true

  include PgSearch
  pg_search_scope :pgsearch,
    against: [:email, :alias],
    using: {  tsearch: { prefix: true, any_word: true },
              dmetaphone: { any_word: true, sort_only: true },
              trigram: { threshold: 0.3 }
            },
    ignoring: :accents

  def friends
    users
    .uniq
    .select{ |user| user != self}
  end

  def self.selected_users(ids)
    where(id: ids)
    .reverse
  end

end
