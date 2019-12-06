module Admin::DashboardAdminHelper
  def genderInString(sex)
    return sex ? "Nữ" : "Nam"
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

end
