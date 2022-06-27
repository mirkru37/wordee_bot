require 'rails_helper'

RSpec.describe Chat, type: :model do
  it { is_expected.to have_db_column(:id).of_type(:integer) }
  it { is_expected.to have_db_column(:chat_type).of_type(:integer) }
end
