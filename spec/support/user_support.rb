module CreateRandomString
  def create_random_string(start_number, end_number)
    tmp = [('a'..'z'), ('0'..'9')].map { |i| i.to_a }.flatten
    string = (start_number...end_number).map { tmp[rand(tmp.length)] }.join
    return string
  end

end