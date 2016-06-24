require 'byebug'

describe Vindi::Charge do
  let(:response) { parsed_response('charges.json') }

  before do
    allow_any_instance_of(Vindi::Request).to(
      receive(:perform).and_return(response)
    )
  end

  describe '.all' do
    context 'given a successful request' do
      subject { described_class.all }

      it { expect(subject).to be_a(Array) }

      it { expect(subject.first).to be_a(Vindi::Charge) }
    end
  end

  describe 'times should be parsed' do
    context 'given a successful request' do
      subject { described_class.all.first }

      it { expect(subject.due_at_time).to be_a Time }
    end
  end

  describe '.paid_charges_per_users' do
    context 'given a successful request' do
      subject { described_class.paid_charges_per_users }

      it { expect(subject).to be_a(Hash) }

      it { expect(subject.keys.first).to match(/@example.com/) }

      it { expect(subject.values.first.first.status).to eq 'paid' }
    end
  end
end
