module ApplicationHelper
  def title(*parts)
    if parts.present?
      content_for(:title) { (parts << t('website')).join(' - ') } 
    end
  end
end
