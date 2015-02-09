require 'rails_helper'

RSpec.describe Peoplefinder::CsvPeopleImporter, type: :service do

  before do
    allow(Rails.configuration).to receive(:valid_login_domains).and_return(['valid.gov.uk'])
  end

  subject(:importer) { described_class.new(csv) }

  describe '#valid?' do
    subject { importer.valid? }

    before { subject }

    context 'when csv has valid format' do
      context 'when all people have surname and email' do
        let(:csv) do
          <<CSV
email,given_name,surname
peter.bly@valid.gov.uk,Peter,Bly
jon.o.carey@valid.gov.uk,Jon,O'Carey
CSV
        end

        it { is_expected.to be true }

        it 'errors are empty' do
          expect(importer.errors).to be_empty
        end
      end

      context 'when some people have incorrect details' do
        let(:csv) do
          <<CSV
email,given_name,surname
peter.bly@valid.gov.uk,Peter,Bly
jon.o. carey@valid.gov.uk,Jon,O'Carey
jack@invalid.gov.uk,Jack,
CSV
        end

        it { is_expected.to be false }

        # These errors come from translation file, so may be different when the engine is used
        it 'errors contain missing columns' do
          expect(importer.errors).to match_array([
            %q(row "jon.o. carey@valid.gov.uk,Jon,O'Carey": Email isn’t valid),
            'row "jack@invalid.gov.uk,Jack,": Surname is required, Email you have entered can’t be used to access People Finder'
          ])
        end
      end
    end

    context 'when the csv has missing columns' do
      let(:csv) do
        <<CSV
email
peter.bly@valid.gov.uk
CSV
      end

      it { is_expected.to be false }

      it 'errors contain missing columns' do
        expect(importer.errors).to match_array([
          'given_name column is missing',
          'surname column is missing'
        ])
      end
    end
  end
end
