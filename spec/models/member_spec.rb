require 'rails_helper'

RSpec.describe Member, type: :model do
  it { should have_many :connections }
  it { should have_many :reverse_connections }
  it { should have_many :babies }
  it { should have_many :procreators }
  it { should have_many :articles }
  it { should belong_to :partner }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :birth_date }
  it { should validate_presence_of :sex }


  describe 'update partner after save' do
    let!(:another_member) { create(:member, sex: "female") }
    subject { build(:member, partner: another_member) }

    it 'call update_partner' do
      expect(subject).to receive(:update_partner)
      subject.save!
    end

    it 'update partner column' do
      subject.save!
      another_member.reload
      expect(another_member.partner).to eq(subject)
    end
  end

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
    let!(:member) { create(:member, first_name: 'Петр', last_name: "Гуськов", middle_name: "аркадьевич") }

    it 'should give full name' do
      expect(member.full_name).to eq("Петр Аркадьевич Гуськов")
    end
  end

  describe '#full_name_with_year' do
    let!(:member) { create(:member, first_name: 'Петр', last_name: "Гуськов", middle_name: "аркадьевич", birth_date: Date.new(2020, 2, 3)) }

    it 'give full_name with year' do
      expect(member.full_name_with_year).to eq("Петр Аркадьевич Гуськов (2020)")
    end
  end
end
