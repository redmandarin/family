require 'rails_helper'

RSpec.describe Member, type: :model do
  it { should have_many :connections }
  it { should have_many :reverse_connections }
  it { should have_many :children }
  it { should have_many :parents }
  it { should belong_to :partner }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :birth_date }
  it { should validate_presence_of :sex }
end
