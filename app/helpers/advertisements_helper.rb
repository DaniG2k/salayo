module AdvertisementsHelper
  def display_ad_type(advertisement)
    type = advertisement.ad_type

    content_tag(:span, class: "badge ads-badge badge-pill ad-#{type}") do
      type
    end.html_safe
  end
end
