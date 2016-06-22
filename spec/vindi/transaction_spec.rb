module Vindi
  describe Transaction do

    describe ".all" do

      context "given a successful request" do
        let(:response) { parsed_response("transaction.json") }

        before do
          allow_any_instance_of(Request).to receive(:perform).and_return(response)
        end

        subject { described_class.all }

        it { expect(subject).to be_a(Array) }

        it { expect(subject.first).to be_a(Transaction) }

      end

    end

  end

end
