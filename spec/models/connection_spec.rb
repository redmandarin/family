require 'rails_helper'

RSpec.describe Connection, type: :model do

  it { should belong_to :parent }
  it { should belong_to :child}

  it { should validate_presence_of :parent_id }
  it { should validate_presence_of :child_id }
end
