# Copyright (c) 2015 Scott Williams

require 'net/http'
require 'json'

module IssueExporting
  class Exporter

    attr_accessor :outputter

    def initialize(owner, repo, token, options = {})
      @owner = owner
      @repo = repo
      @token = token
      @outputter = FileOutputter.new options
    end

    def export
      url = URI.parse make_url
      response = Net::HTTP::get url
      outputter.write response
    end

    private
    def make_url
      url_format = "https://api.github.com/repos/%s/%s/issues?access_token=%s"
      url_format % [@owner, @repo, @token]
    end

  end
end

