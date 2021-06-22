# frozen_string_literal: true

require 'spec_helper'

describe 'iis_webserver::iis_site' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
