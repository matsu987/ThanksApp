if @company_admin.present?
  @company_admin_data = {
    id: @company_admin.id,
    name: @company_admin.name,
    post_number: @company_admin.post_number,
    address: @company_admin.address,
    phone_number: @company_admin.phone_number,
    logo: @company_admin.logo,
    release_time: @company_admin.release_time.strftime("%Y年%m月%d日 %H:%M")
  }
  json.company @company_admin_data
  json.admin   true
end

if @company.present?
  @company_data = {
    id: @company.id,
    name: @company.name,
    post_number: @company.post_number,
    address: @company.address,
    phone_number: @company.phone_number,
    logo: @company.logo,
    release_time: @company.release_time.strftime("%Y年%m月%d日 %H:%M")
  }
  json.company @company_data
  json.admin   false
end