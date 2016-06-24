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
      subject do
        described_class.all
      end

      it { expect(subject).to be_a(Array) }

      it { expect(subject.first).to be_a(Vindi::Charge) }
    end
  end

  describe '.paid_charges_per_users' do
    context 'given a successful request' do
      subject do
        described_class.paid_charges_per_users
      end

      it { expect(subject).to be_a(Hash) }

      it { expect(subject.keys.first).to match(/@example.com/) }

      it { expect(subject.values.first.first.status).to eq 'paid' }
    end
  end
end
