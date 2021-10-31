require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  subject { described_class.new }

  describe "validations" do
    it { is_expected.to validate_presence_of(:mileage) }

    it { is_expected.to validate_inclusion_of(:engine_status).in_array(described_class::ENGINE_STATUSES).allow_nil }

    it { is_expected.to validate_inclusion_of(:wheels).in_array([ 0, 1, 2, 3, 4 ]).allow_nil }

    context "when the vehicle_type is a motorcycle" do
      subject { described_class.new(vehicle_type: motorcycle) }

      let(:motorcycle) { Motorcycle.new }

      it { is_expected.to validate_inclusion_of(:wheels).in_array([ 0, 1, 2, ]).allow_nil }
    end
  end
end
