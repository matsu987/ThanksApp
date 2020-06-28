if @groups.present?
  json.array!    @groups.each do |group|
	  json.company           group[:company]
    json.parent_group      group[:parent_group]
    json.child_group       group[:child_group]
    json.grandchild_group  group[:grandchild_group]
  end
end