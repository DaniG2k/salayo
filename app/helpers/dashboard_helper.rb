module DashboardHelper
  def active_if(section)
    current_page?(section) ? 'active' : ''
  end
end
