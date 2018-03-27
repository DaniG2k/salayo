module ApplicationHelper
  def title(*parts)
    if parts.present?
      content_for(:title) do
        title_with_slogan = "#{t('website')} | #{t('slogan')}"
        parts.unshift('🚧  DEV') if Rails.env.development?
        (parts << title_with_slogan).join(' - ')
      end
    end
  end

  def copyright
    years_since_foundation = if Time.zone.now.year > 2017
      "2017-#{Time.zone.now.year}"
    else
      '2017'
    end
    fa_icon('copyright', text: "#{t('website')} #{years_since_foundation}")
  end

  def user_language
    I18n.t('language')
  end

  def user_locale
    current_user.present? ? current_user.locale : 'en'
  end

  def admins_only(&block)
    block.call if admin?
  end

  def owners_only(&block)
    if admin? || current_user.roles.pluck(:name).include?('owner')
      block.call
    end
  end

  def admin?
    current_user.has_role?(:admin)
  end
end
