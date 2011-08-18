module Overseer
  module Duties
    attr_reader :current_test, :current_suite

    def build_test(name, &block)
      @current_test = Test.new(name, &block)
      @current_suite.tests << @current_test
    end

    def build_suite(suite)
      @current_suite = Suite.new(suite)
      suites << @current_suite
    end

    def suites
      @suites ||= []
    end

    def failures_exists?
      total_failures > 0
    end

    def errors_exists?
      total_errors > 0
    end

    def total_assertions
      suites.inject(0) { |total, suite| total + suite.total_test_assertions }
    end

    def total_failures
      suites.inject(0) { |total, suite| total + suite.total_test_failures }
    end

    def total_errors
      suites.inject(0) { |total, suite| total + suite.total_test_errors }
    end

    def total_tests
      suites.inject(0) { |total, suite| total + suite.tests.size }
    end

    def total_time
      suites.inject(0) { |total, suite| total + suite.total_test_time }
    end
  end
end
