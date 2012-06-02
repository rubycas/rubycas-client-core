require 'spec_helper'

describe RubyCas::Client do
  describe "#initialize" do

    context "call with nil" do
      let(:config) { nil }
      it "should raise an argument error" do
        expect { RubyCas::Client.new(config) }.to raise_error(ArgumentError, /Could not configure/)
      end
    end

    context "call with empty hash" do
      let(:config) { Hash.new }
      it "should raise an argument error" do
        expect { RubyCas::Client.new(config) }.to raise_error(ArgumentError, /cas_base_url/)
      end
    end

    context "call with hash that includes cas_base_url" do
      let(:config) { { :cas_base_url => "https://cas.server.local/cas" } }
      subject { RubyCas::Client.new(config) }
      it "should set the cas_base_url" do
        subject.config.cas_base_url.should_not be_nil
        subject.config.cas_base_url.should == config[:cas_base_url]
      end

      context "call with hash keys that are strings" do
        let(:config) { { "cas_base_url" => "https://cas.server.local/cas" } }
        it "should set the cas_base_url" do
          subject.config.cas_base_url.should_not be_nil
          subject.config.cas_base_url.should == config["cas_base_url"]
        end
      end
    end

    context "call with path to file" do
      include UsesTempFiles

      in_directory_with_file("client_spec_basic_config.yml")

      before do
        content_for_file <<-FILE
---
cas_base_url: https://cas.server.local/cas
        FILE
      end

      subject { RubyCas::Client.new("client_spec_basic_config.yml") }

      it "should load the file" do
        subject.config.cas_base_url.should == 'https://cas.server.local/cas'
      end

      context "where the path is invalid" do
        it "should raise an error" do
          expect {
            RubyCas::Client.new("not_a_real_file.yml")
          }.to raise_error /No such file or directory/
        end
      end
    end
  end
end
