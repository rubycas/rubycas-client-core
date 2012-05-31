require 'spec_helper'

module RubyCas
    describe Client::Config do
      describe "#initialize" do

        context "call with nil" do
          let(:config) { nil }
          it "should raise an argument error" do
            expect { Client::Config.new(config) }.to raise_error(ArgumentError, /cas_base_url/)
          end
        end

        context "call with empty hash" do
          let(:config) { Hash.new }
          it "should raise an argument error" do
            expect { Client::Config.new(config) }.to raise_error(ArgumentError, /cas_base_url/)
          end
        end

        context "includes cas_base_url" do
          let(:config) do
            { :cas_base_url => "http://cas.server.local/cas" }
          end
          subject { Client::Config.new(config) }
          it "should set the cas_base_url" do
            subject.cas_base_url.should_not be_nil
            subject.cas_base_url.should == config[:cas_base_url]
          end

          context "hash keys are strings" do
            let(:config) do
              { "cas_base_url" => "http://cas.server.local/cas" }
            end
            it "should raise an argument error" do
              expect { Client::Config.new(config) }.to raise_error(ArgumentError, /cas_base_url/)
            end
          end
        end
      end
    end
  end
