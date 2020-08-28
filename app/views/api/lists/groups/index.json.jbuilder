
json.array! @parent_groups do |parent|
  json.parent do
    json.id         parent.id
    json.name       parent.name
  end
end


json.array! @children_groups do |child|
  json.child do
    json.id         child.id
    json.name       child.name
  end
end

json.array! @grandchildren_groups do |grandchild|
  json.grandchild do
    json.id         grandchild.id
    json.name       grandchild.name
  end
end