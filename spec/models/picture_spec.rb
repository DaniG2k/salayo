# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  image          :string
#  description    :string
#  imageable_type :string
#  imageable_id   :integer
#

require 'rails_helper'

RSpec.describe Picture, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
