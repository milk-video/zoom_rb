# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Recording do
  let(:zc) { zoom_client }
  let(:args) { { account_id: 1 } }

  describe '#account_recording_list action' do
    before :each do
      stub_request(
        :get,
        zoom_url("/accounts/#{args[:account_id]}/recordings")
      ).to_return(
        status: 200,
        body: json_response('recording', 'list'),
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    it "requires an 'account_id' argument" do
      expect { zc.account_recording_list }.to raise_error(Zoom::ParameterMissing)
    end

    it 'returns a hash' do
      expect(zc.account_recording_list(args)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(zc.account_recording_list(args)['total_records']).to eq(1)
    end

    it "returns 'meetings' Array" do
      expect(zc.account_recording_list(args)['meetings']).to be_kind_of(Array)
    end
  end

  describe '#account_recording_list! action' do
    it 'raises NoMethodError exception' do
      expect {
        zc.account_recording_list!(args)
      }.to raise_error(NoMethodError)
    end
  end
end
