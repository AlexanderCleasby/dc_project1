class TwitterFeed < ApplicationRecord
	
	attr_accessor :current_user, :client, :followed_account, :tweets

	def initialize(user)
		@current_user = user
		@client = initTwitterApi
	end

	def initTwitterApi
		Twitter::REST::Client.new do |config|
  		config.consumer_key = ENV['CONSUMER_KEY']
  		config.consumer_secret = ENV['CONSUMER_SECRET']
  		config.access_token = ENV['ACCESS_TOKEN']
  		config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
		end
	end
	
	def get_and_save_followed_account(twitterHandle)
		followed_account_info = @client.user(twitterHandle)
		platform = Platform.find_or_create_by(name:"Twitter",api_base_url:"https://api.twitter.com/1.1/", user_id: @current_user.id)
		@followed_account = FollowedAccount.find_or_create_by(
			account_id: followed_account_info.id,
			account_name: twitterHandle,
			platform_id: platform.id
		)
		platform.followed_accounts << @followed_account
		platform.save
	end
	
	def get_tweets
		@tweets = @client.user_timeline(@followed_account.account_id)
	end
	
	def save_tweets_as_posts
		@tweets.each do |tweet|
			Post.find_or_create_by(
				content: tweet.text,
				timestamp: tweet.created_at,
				author: tweet.user.name,
				social_media_platform: "Twitter",
				marked_as_read: false,
				followed_account_id: @followed_account.id
			)
		end 
	end
end