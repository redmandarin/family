require 'rails_helper'

RSpec.describe Member, type: :model do
  it { should have_many :connections }
  it { should have_many :reverse_connections }
  it { should have_many :babies }
  it { should have_many :procreators }
  it { should belong_to :partner }
  it { should have_and_belong_to_many :articles }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :birth_date }
  it { should validate_presence_of :sex }

  let!(:member) { create(:member, first_name: 'Петр', last_name: "Гуськов", middle_name: "аркадьевич") }

  describe 'titleize name after create' do
    subject { build(:member, last_name: "гуськов", first_name: "петька", middle_name: "аркадьевич")}

    it 'call before save' do
      expect(subject).to receive(:titleize)
      subject.save!
    end

    it 'uppercase first letters' do
      subject.save!
      expect(subject.last_name).to eq("Гуськов")
      expect(subject.first_name).to eq("Петька")
      expect(subject.middle_name).to eq("Аркадьевич")
    end
  end

  describe 'user full name' do
    it 'should give full name' do
      expect(member.full_name).to eq("Петр Аркадьевич Гуськов")
    end
  end

  describe '.tree' do
    let!(:member) { create(:member) }
    let!(:wife_member) { create(:member, partner: member) }
    let!(:child) { create(:member) }
    let!(:child_of_child) { create(:member) }
    let!(:connection) { create(:connection, procreator: member, baby: child)}
    let!(:another_connection) { create(:connection, procreator: child, baby: child_of_child)}

    it 'returns hash with all children and children and ...' do
      expect(member.siblings).to eq([1,2,3])
    end
  end
end
