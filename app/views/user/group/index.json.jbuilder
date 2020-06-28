if @groups.present?
  json.array!    @groups.each do |group|
	  json.id     group.id
    json.name   group.name
  end
end