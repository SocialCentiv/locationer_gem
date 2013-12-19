require 'spec_helper'

module Locationer
  describe GeonameParser do
    before(:each) do
      @tsv_file_path = fixture('US-10.csv')
      @geo_parser = Locationer::GeonameParser.new(@tsv_file_path)
    end

    it "should create 10 records" do
      expect{@geo_parser.db_insert(progressbar: false)}.to change{Locationer::Location.count}.by(10)
    end
  end
end