if @company_admin.present?
  json.company @company_admin
  json.admin   true
end

if @company.present?
  json.company @company
  json.admin   false
end