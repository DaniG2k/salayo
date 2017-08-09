module ApplicationHelper
  def title(*parts)
    if parts.present?
      content_for(:title) do
        if Rails.env.development?
          (parts.unshift('🚧 DEV') << t('website')).join(' - ')
        else
          (parts << t('website')).join(' - ')
        end
      end
    end
  end

  def copyright
    years_since_foundation = if Time.zone.now.year > 2017
      "2017-#{Time.zone.now.year}"
    else
      '2017'
    end
    "&copy; #{t('website')} #{years_since_foundation}".html_safe
  end

  def user_locale
    current_user.present? ? current_user.locale : 'en'
  end

  def admins_only &block
    block.call if admin?
  end

  def owners_only &block
    if admin? || Listing.with_roles(:owner, current_user).present?
      block.call
    end
  end

  def admin?
    current_user.has_role?(:admin)
  end
end
