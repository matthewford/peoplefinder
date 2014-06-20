class Group < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :parent, class_name: 'Group'
  has_many :children, class_name: 'Group', foreign_key: 'parent_id'
  has_many :memberships, dependent: :destroy
  has_many :leaderships, -> { where(leader: true) }, class_name: 'Membership'
  has_many :leaders, through: :leaderships, source: :person

  validates_presence_of :name

  def self.departments
    where(parent_id: nil)
  end

  def to_s
    name
  end

  def level
    parent ? parent.level.succ : 0
  end
end