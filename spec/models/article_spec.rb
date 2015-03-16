require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should have_and_belong_to_many :members }
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
end