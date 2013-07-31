require "issues-to-care/version"
require "issues-to-care/configuration"

module IssuesToCare
  def self.configuration
    @configuration ||= IssuesToCare::Configuration.new
  end

  def self.configuration=(new_configuration)
    @configuration = new_configuration
  end

  def self.configure
    yield configuration if block_given?
  end


  def self.info
    Rails.cache.fetch('issues-to-care:info', expires_in: 1.hour) { self.get() }

    #{"created_on"=>2013-05-28 14:14:10 +0200,
    #"creator"=>nil,
    #"description"=>"Fet Motion",
    #"email_mailinglist"=>"",
    #"email_writers"=>true,
    #"followers_count"=>1,
    #"fork_of"=>nil,
    #"forks_count"=>0,
    #"has_issues"=>true,
    #"has_wiki"=>false,
    #"is_fork"=>false, "is_mq"=>false, "is_private"=>true,
    #"language"=>"ruby",
    #"last_updated"=>2013-07-25 18:29:18 +0200,
    #"logo"=>"https://bitbucket-assetroot.s3.amazonaws.com/c/photos/2013/May/28/fetmotion-logo-3943927272-3_avatar.png",
    #"mq_of"=>nil, "name"=>"FetMotion",
    #"no_public_forks"=>true, "owner"=>"VForge",
    #"read_only"=>false, "resource_uri"=>"/1.0/repositories/VForge/fetmotion",
    #"scm"=>"git",
    #"size"=>38510701,
    #"slug"=>"fetmotion",
    #"state"=>"available",
    #"utc_created_on"=>"2013-05-28 10:14:10+00:00",
    #"utc_last_updated"=>"2013-07-25 14:29:18+00:00",
    #"website"=>"http://fetmotion.com/"}
  end

  def self.has_issues?
    self.info['has_issues']
  end

  def self.last_updated
    self.info['last_updated'].to_datetime
  end

  def self.list
    issues = []

    self.raw_list.each do |issue|
      issues << {
        id: issue['local_id'],
        kind: issue['metadata']['kind'],
        priority: issue['priority'],
        title: issue['title'],
        content: issue['content'],
        created_on: issue['created_on'].to_datetime
      }
    end

    issues
  end

  def self.raw_list
    Rails.cache.fetch('issues-to-care:raw_list', expires_in: 5.minutes) do
      batch_size  = 1
      batch_start = 0

      issues = []

      begin
        issues_batch = self.get('/issues', {limit: batch_size, start: batch_start})['issues']
        issues.concat(issues_batch)

        batch_start += batch_size
      end until issues_batch.empty?

      issues
    end

    #{"count"=>1,
    #"filter"=>{},
    #"issues"=>[{
    #"comment_count"=>0,
    #"content"=>"just like in title",
    #"created_on"=>2013-07-25 18:30:58 +0200,
    #"follower_count"=>0,
    #"is_spam"=>false,
    #"local_id"=>3,
    #"metadata"=>{"component"=>nil, "kind"=>"bug", "milestone"=>nil, "version"=>nil},
    #"priority"=>"trivial",
    #"resource_uri"=>"/1.0/repositories/VForge/fetmotion/issues/3",
    #"status"=>"new",
    #"title"=>"Test create issue as anon",
    #"utc_created_on"=>"2013-07-25 14:30:58+00:00",
    #"utc_last_updated"=>"2013-07-25 14:30:58+00:00"}],
    #"search"=>nil
    #}
  end


  private

  def self.get path = '', params = {}
    params[:format] = :yaml

    YAML::load(self.connection(path, params).get)
  end

  def self.rest_connection path = '', params = {}
    case @configuration.rcs
      when :bitbucket
        RestClient::Resource.new("https://api.bitbucket.org/1.0/repositories/#{@configuration.repo_user}/#{@configuration.repo_slug}#{path}?#{params.to_query}", @configuration.username, @configuration.password)
      else
        nil
    end
  end
end
