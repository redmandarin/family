require 'rails_helper'

RSpec.describe Connection, type: :model do

  it { should belong_to :procreator }
  it { should belong_to :baby}

  it { should validate_presence_of :procreator_id }
  it { should validate_presence_of :baby_id }

  let(:member) { create(:member, first_name: 'Петр', last_name: "Гуськов", middle_name: "аркадьевич") }
  let(:another_member) { create(:member, first_name: 'Аркадий1', last_name: "Гуськов", middle_name: "аркадьевич") }

  describe '.all_connections' do
    let(:parent_member) { create(:member, first_name: 'Аркадий2', last_name: "Гуськов", middle_name: "аркадьевич") }
    let(:connection) { create(:connection, procreator: member, baby: another_member) }
    let(:parent_connection) { create(:connection, procreator: parent_member, baby: member) }

    it 'gives all connections' do
      expect(Connection.all_connections(member)).to match_array([connection, parent_connection])
    end
  end
end
