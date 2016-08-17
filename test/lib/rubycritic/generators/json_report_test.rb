require 'test_helper'
require 'rubycritic/core/analysed_modules_collection'
require 'rubycritic/generators/json_report'
require 'json'

describe RubyCritic::Generator::JsonReport do
  describe '#generate_report' do
    before do
      FileUtils.rm('test/samples/report.json') if File.file?('test/samples/report.json')
      create_analysed_modules_collection
      generate_report
    end

    it 'creates a report.json file' do
      assert File.file?('test/samples/report.json'), 'expected report.json file to be created'
    end

    it 'report file has data inside' do
      data = File.read('test/samples/report.json')
      assert data != '', 'expected report file not to be empty'
    end
  end

  def create_analysed_modules_collection
    @analysed_modules_collection = RubyCritic::AnalysedModulesCollection.new('test/samples/')
    @analysed_modules_collection.each do |analysed_module|
      analysed_module.complexity = 0
      analysed_module.churn = 10
      analysed_module.duplication = 20
      analysed_module.methods_count = 0
      analysed_module.smells = []
    end
    RubyCritic::Config.root = 'test/samples'
  end

  def generate_report
    report = RubyCritic::Generator::JsonReport.new(@analysed_modules_collection)
    report.generate_report
  end
end
