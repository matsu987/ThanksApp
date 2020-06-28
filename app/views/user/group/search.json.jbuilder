if @group_children.present?
  json.array!    @group_children.each do |group|
	  json.id     group.id
    json.name   group.name
  end
end