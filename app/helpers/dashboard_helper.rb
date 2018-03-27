module DashboardHelper
  def sidebar_items
    [
      {
        icon: 'S',
        icon_with_text: t('website'),
        path: dashboard_path,
        class: 'logo-text',
        admins_only: false,
        owners_only: false
      },
      {
        icon: fa_icon('user-secret'),
        icon_with_text: fa_icon('user-secret', text: 'Admin lounge'),
        path: admin_root_path,
        class: active_if(admin_root_path),
        admins_only: true,
        owners_only: false
      },
      {
        icon: fa_icon('dashboard'),
        icon_with_text: fa_icon('dashboard', text: 'Dashboard'),
        path: dashboard_path,
        class: active_if(dashboard_path),
        admins_only: false,
        owners_only: false
      },
      {
        icon: fa_icon('home'),
        icon_with_text: fa_icon('home', text: 'My listings'),
        path: my_listings_path,
        class: active_if(my_listings_path),
        admins_only: false,
        owners_only: true
      },
      {
        icon: fa_icon('plus'),
        icon_with_text: fa_icon('plus', text: 'Add listing'),
        path: new_listing_path,
        class: active_if(new_listing_path),
        admins_only: false,
        owners_only: true
      },
      {
        icon: fa_icon('search'),
        icon_with_text: fa_icon('search', text: 'Search listings'),
        path: search_path,
        class: active_if(search_path),
        admins_only: false,
        owners_only: false
      },
      {
        icon: fa_icon('file-text'),
        icon_with_text: fa_icon('file-text', text: 'My ads'),
        path: my_advertisements_path,
        class: active_if(my_advertisements_path),
        admins_only: false,
        owners_only: false
      },
      {
        icon: fa_icon('address-card'),
        icon_with_text: fa_icon('address-card', text: 'Roommate ads'),
        path: advertisements_path,
        class: active_if(advertisements_path),
        admins_only: false,
        owners_only: false
      },
      {
        icon: fa_icon('paper-plane'),
        icon_with_text: fa_icon('paper-plane', text: 'Messages'),
        path: messages_path,
        class: active_if(messages_path),
        admins_only: false,
        owners_only: false
      }
    ]
  end

  def active_if(section)
    current_page?(section) ? 'active' : ''
  end
end
