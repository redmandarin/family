# == Schema Information
#
# Table name: connections
#
#  id            :integer          not null, primary key
#  procreator_id :integer
#  baby_id       :integer
#

require 'rails_helper'

RSpec.describe Connection, type: :model do

  it { should belong_to :procreator }
  it { should belong_to :baby}

  it { should validate_presence_of :procreator_id }
  it { should validate_presence_of :baby_id }

  let(:member) { create(:member, first_name: 'Петр', last_name: "Гуськов", middle_name: "аркадьевич") }
  let(:another_member) { create(:member, first_name: 'Аркадий1', last_name: "Гуськов", middle_name: "аркадьевич") }
  let(:connection) { create(:connection, procreator: member, baby: another_member) }

  describe '.all_connections' do
    let(:parent_member) { create(:member, first_name: 'Аркадий2', last_name: "Гуськов", middle_name: "аркадьевич") }
    let(:parent_connection) { create(:connection, procreator: parent_member, baby: member) }

    it 'gives all connections' do
      expect(Connection.all_connections(member)).to match_array([connection, parent_connection])
    end
  end

  describe 'set_parent_ancestry' do
    # let(:another_member) { create(:member, sex: "female") }
    subject { build(:connection, procreator: member, baby: another_member)}
    
    it 'call after_save' do
      expect(subject).to receive(:set_parent_ancestry)
      subject.save!
    end

    it 'does not update ancestry if procreator is female' do
      subject.procreator.update(sex: "female")
      subject.save!
      expect(another_member.ancestry).to eq(nil)
    end

    it 'update ancestry if procreator is male' do
      subject.save!
      expect(another_member.ancestry).not_to eq(nil)
    end
  end

  describe 'erase ancestry after destroy connection' do
    subject { build(:connection, procreator: member, baby: another_member) }
    let(:another_member) { create(:member, first_name: 'Аркадий1', last_name: "Гуськов", middle_name: "аркадьевич", ancestry: "123") }
    let(:connection) { create(:connection, procreator: member, baby: another_member) }
    
    it 'call destroy ancestry' do
      subject.save!
      expect(subject).to receive(:erase_ancestry)
      subject.destroy!
    end


    it 'erase ancestry' do
      connection
      connection.baby.update(parent_id: another_member.id)
      connection.destroy
      expect(connection.baby.ancestry).to eq(nil)
    end

    it 'does not erase if procreator is female' do
      member.update(sex: "female")
      connection.baby.update(parent_id: another_member.id)
      connection.destroy!
      expect(connection.baby.ancestry).not_to eq(nil)
    end
  end
end
