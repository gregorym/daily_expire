require 'rspec'
require File.expand_path File.dirname(__FILE__) + '/lib/daily_expire.rb'

describe DailyExpire::ActiveSupport::Cache do

  context "expires every day" do
    context "when it is 5 am" do
      context "and expires every day at 6 am" do
        it "should expires_in 60 minutes" do
          now = Time.local(2012, 6, 22, 5)
          stub(Time).now {now}

          cache = ActiveSupport::Cache::Store.new
          options = cache.send(:calc_expires_in, :every => :day, :at => '6 am')

          options[:expires_in].should eql 60 * 60
        end
      end
      context "and expires every day at 5 pm" do
        it "should expires_in 11 hours" do
          now = Time.local(2012, 6, 22, 5)
          stub(Time).now {now}

          cache = ActiveSupport::Cache::Store.new
          options = cache.send(:calc_expires_in, :every => :day, :at => '4 pm')

          options[:expires_in].should eql 11 * 60 * 60
        end
      end
    end
  end

  context "expires any day of the week" do
    context "when it is monday 5 am" do
      context "and we expire every wednesday at 6 am" do
        before do
          now = Time.local(2012, 6, 25, 5)
          stub(Time).now {now}
        end

        it "should expire in 49 hours" do
          cache = ActiveSupport::Cache::Store.new
          options = cache.send(:calc_expires_in, :every => :wednesday, :at => '6 am')

          options[:expires_in].should eql 49 * 60 * 60
        end
      end

      context "and we expire every sunday at 2am" do
        before do
          now = Time.local(2012, 6, 25, 5)
          stub(Time).now {now}
        end

        it "should expire in X hours" do
          cache = ActiveSupport::Cache::Store.new
          options = cache.send(:calc_expires_in, :every => :sunday, :at => '2 am')

          options[:expires_in].should eql 507600
        end

      end
    end
  end

end