class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  belongs_to :company
  has_ancestry

  def self.groups_create(group1, group2, group3)
    
    if @group_1.save
      if @group_params_2[:name] != ""
        @group_2 = @group_1.children.new(@group_params_2)
        if @group_2.save
          if @group_params_3[:name] != ""
            @group_3 = @group_2.children.new(@group_params_3)
            if @group_3.save
            end
          end
        end
      end
      redirect_to regist_groups_path
    else
      render :new
    end
  end
end
