class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_ancestry

  def self.search_units
    units = Group.where(ancestry: nil)
    return units
  end

  def self.search_groups
    units = Group.search_units
    groups = []
    units.each do |unit|
      unit_have_groups = Group.children_of unit
      unit_have_groups.each do |group|
        groups.push(group)
      end
    end
    return groups
  end

  def self.search_teams
    groups = Group.search_groups
    teams = []
    groups.each do |group|
      group_have_teams = Group.children_of group
      group_have_teams.each do |team|
        teams.push(team)
      end
    end
    return teams
  end
end
