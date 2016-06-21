module Vindi
  describe Charge do

    describe ".all" do

      context "given a successful request" do
        let(:response) { parsed_response("charges.json") }

        before do
          allow_any_instance_of(Request).to receive(:perform).and_return(response)
        end

        subject { described_class.all }

        it { expect(subject).to be_a(Array) }

        it { expect(subject.first).to be_a(Charge) }

      end

    end

  end

end